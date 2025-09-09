import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/data/models/exchange_rate_model.dart';
import 'package:currency_converter/data/models/exchange_rates_model.dart';
import 'package:currency_converter/data/repos/currency/currency_repo.dart';
import 'package:currency_converter/domain/use_cases/get_today_exchange_rate_use_case.dart';
import 'package:currency_converter/domain/use_cases/parameters/exchange_rates_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExchangeRateRepository extends Mock implements CurrencyRepo {}

void main() {
  late GetTodayExchangeRateUseCase sut;
  late MockExchangeRateRepository mockRepository;

  setUp(() {
    mockRepository = MockExchangeRateRepository();
    sut = GetTodayExchangeRateUseCase(mockRepository);
  });

  group('GetTodayExchangeRateUseCase', () {
    const String tBaseCurrency = 'USD';
    const String tTargetCurrency = 'EUR';
    final tExchangeRate = ExchangeRatesModel(
      baseCurrency: tBaseCurrency,
      rates: [ExchangeRateModel(targetCurrency: tTargetCurrency, rate: 0.85)],
    );

    test('should return exchange rate when repository returns data', () async {
      // arrange
      when(
        () => mockRepository.getExchangeRates(
          base: any(named: 'base'),
          date: any(named: 'date'),
        ),
      ).thenAnswer((_) async => Right(tExchangeRate));
      // act
      final result = await sut(
        ExchangeRatesParams(
          baseCurrency: tBaseCurrency,
          targetCurrency: tTargetCurrency,
        ),
      );
      // assert
      expect(result, Right(tExchangeRate));
      verify(
        () => mockRepository.getExchangeRates(
          base: any(named: 'base'),
          date: any(named: 'date'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository returns failure', () async {
      // arrange
      final tFailure = AppUnexpectedException();
      when(
        () => mockRepository.getExchangeRates(
          base: any(named: 'base'),
          date: any(named: 'date'),
        ),
      ).thenAnswer((_) async => Left(tFailure));
      // act
      final result = await sut(
        ExchangeRatesParams(
          baseCurrency: tBaseCurrency,
          targetCurrency: tTargetCurrency,
        ),
      );
      // assert
      expect(result, isA<Left<AppException, ExchangeRatesModel>>());
      verify(
        () => mockRepository.getExchangeRates(
          base: any(named: 'base'),
          date: any(named: 'date'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
