import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/data/models/exchange_rate_model.dart';
import 'package:currency_converter/data/models/exchange_rates_model.dart';
import 'package:currency_converter/data/repos/currency/currency_repo.dart';
import 'package:currency_converter/domain/entities/exchange_rate_entity.dart';
import 'package:currency_converter/domain/use_cases/get_last_week_exchange_rates_use_case.dart';
import 'package:currency_converter/domain/use_cases/parameters/exchange_rates_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyRepo extends Mock implements CurrencyRepo {}

void main() {
  late GetLastWeekExchangeRatesUseCase sut;
  late MockCurrencyRepo mockCurrencyRepo;

  setUp(() {
    mockCurrencyRepo = MockCurrencyRepo();
    sut = GetLastWeekExchangeRatesUseCase(mockCurrencyRepo);
  });

  group('GetLastWeekExchangeRatesUseCase', () {
    const fromCurrency = 'USD';
    const toCurrency = 'EUR';
    final exchangeRates = ExchangeRatesModel(
      rates: [
        ExchangeRateModel(
          timestamp: 1546546,
          rate: 0.92,
          targetCurrency: toCurrency,
        ),
      ],
    );

    test(
      'should return Right(exchangeRates) when repo returns success',
      () async {
        // arrange
        when(
          () => mockCurrencyRepo.getExchangeRates(
            base: any(named: 'base'),
            date: any(named: 'date'),
          ),
        ).thenAnswer((_) async => Right(exchangeRates));

        // act
        final result = await sut(
          const ExchangeRatesParams(
            targetCurrency: toCurrency,
            baseCurrency: fromCurrency,
          ),
        );

        // assert
        expect(result, isA<Right<AppException, List<ExchangeRateEntity>>>());
        verify(
          () => mockCurrencyRepo.getExchangeRates(
            base: any(named: 'base'),
            date: any(named: 'date'),
          ),
        ).called(7);
        verifyNoMoreInteractions(mockCurrencyRepo);
      },
    );

    test('should return Left(Failure) when repo returns failure', () async {
      // arrange
      final failure = AppUnexpectedException();
      when(
        () => mockCurrencyRepo.getExchangeRates(
          base: any(named: 'base'),
          date: any(named: 'date'),
        ),
      ).thenAnswer((_) async => Left(failure));

      // act
      final result = await sut(
        const ExchangeRatesParams(
          targetCurrency: toCurrency,
          baseCurrency: fromCurrency,
        ),
      );

      // assert
      expect(result, isA<Left<AppException, List<ExchangeRateEntity>>>());
      verify(
        () => mockCurrencyRepo.getExchangeRates(
          base: any(named: 'base'),
          date: any(named: 'date'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockCurrencyRepo);
    });
  });
}
