import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/data/models/exchange_rate_model.dart';
import 'package:currency_converter/data/models/exchange_rates_model.dart';
import 'package:currency_converter/domain/entities/exchange_rate_entity.dart';
import 'package:currency_converter/domain/use_cases/get_last_week_exchange_rates_use_case.dart';
import 'package:currency_converter/domain/use_cases/get_today_exchange_rate_use_case.dart';
import 'package:currency_converter/domain/use_cases/parameters/exchange_rates_params.dart';
import 'package:currency_converter/presentation/common/status.dart';
import 'package:currency_converter/presentation/features/exchange_rates/bloc/exchange_rates_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetLastWeekExchangeRatesUseCase extends Mock
    implements GetLastWeekExchangeRatesUseCase {}

class MockGetTodayExchangeRateUseCase extends Mock
    implements GetTodayExchangeRateUseCase {}

void main() {
  late MockGetLastWeekExchangeRatesUseCase mockLastWeekUseCase;
  late MockGetTodayExchangeRateUseCase mockTodayUseCase;
  late ExchangeRatesBloc bloc;

  setUpAll(() {
    registerFallbackValue(
      const ExchangeRatesParams(baseCurrency: 'USD', targetCurrency: 'EGP'),
    );
  });

  setUp(() {
    mockLastWeekUseCase = MockGetLastWeekExchangeRatesUseCase();
    mockTodayUseCase = MockGetTodayExchangeRateUseCase();
    bloc = ExchangeRatesBloc(
      getExchangeRatesUseCase: mockLastWeekUseCase,
      getTodayExchangeRateUseCase: mockTodayUseCase,
    );
  });

  const baseCurrency = 'USD';
  const targetCurrency = 'EGP';
  final lastWeekRates = [
    ExchangeRateEntity(dateTime: DateTime(2025, 9, 2), rate: 31.0),
  ];
  final todayModel = ExchangeRatesModel(
    baseCurrency: baseCurrency,
    rates: [
      ExchangeRateModel(
        rate: 32.0,
        targetCurrency: targetCurrency,
        timestamp: 1694246400,
      ),
    ],
  );
  final failure = AppUnexpectedException();

  blocTest<ExchangeRatesBloc, ExchangeRatesState>(
    'emits [loading, success] when last week rates are fetched successfully',
    build: () {
      when(
        () => mockLastWeekUseCase(any()),
      ).thenAnswer((_) async => Right(lastWeekRates));
      return bloc;
    },
    act: (bloc) => bloc.add(const ExchangeRatesForLastWeekFetched()),
    expect: () => [
      const ExchangeRatesState(status: Status.loading),
      ExchangeRatesState(
        status: Status.success,
        rates: lastWeekRates,
        baseCurrency: baseCurrency,
        targetCurrency: targetCurrency,
      ),
    ],
    verify: (_) {
      verify(() => mockLastWeekUseCase(any())).called(1);
    },
  );

  blocTest<ExchangeRatesBloc, ExchangeRatesState>(
    'emits [loading, failure] when last week rates fetch fails',
    build: () {
      when(
        () => mockLastWeekUseCase(any()),
      ).thenAnswer((_) async => Left(failure));
      return bloc;
    },
    act: (bloc) => bloc.add(const ExchangeRatesForLastWeekFetched()),
    expect: () => [
      const ExchangeRatesState(status: Status.loading),
      ExchangeRatesState(status: Status.failure, failure: failure),
    ],
    verify: (_) {
      verify(() => mockLastWeekUseCase(any())).called(1);
    },
  );

  blocTest<ExchangeRatesBloc, ExchangeRatesState>(
    'emits [loading, success] when today\'s rate is fetched successfully',
    build: () {
      when(
        () => mockTodayUseCase(any()),
      ).thenAnswer((_) async => Right(todayModel));
      return bloc;
    },
    act: (bloc) => bloc.add(
      const ExchangeRatesForTodayFetched(baseCurrency: baseCurrency),
    ),
    expect: () => [
      const ExchangeRatesState(status: Status.loading),
      ExchangeRatesState(
        status: Status.success,
        todayExchangeRate: todayModel,
        baseCurrency: baseCurrency,
      ),
    ],
    verify: (_) {
      verify(() => mockTodayUseCase(any())).called(1);
    },
  );

  blocTest<ExchangeRatesBloc, ExchangeRatesState>(
    'emits [loading, failure] when today\'s rate fetch fails',
    build: () {
      when(
        () => mockTodayUseCase(any()),
      ).thenAnswer((_) async => Left(failure));
      return bloc;
    },
    act: (bloc) => bloc.add(
      const ExchangeRatesForTodayFetched(baseCurrency: baseCurrency),
    ),
    expect: () => [
      const ExchangeRatesState(status: Status.loading),
      ExchangeRatesState(status: Status.failure, failure: failure),
    ],
    verify: (_) {
      verify(() => mockTodayUseCase(any())).called(1);
    },
  );
}
