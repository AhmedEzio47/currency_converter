import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/data/models/currencies_model.dart';
import 'package:currency_converter/data/models/currency_model.dart';
import 'package:currency_converter/domain/use_cases/get_currencies_use_case.dart';
import 'package:currency_converter/domain/use_cases/use_case.dart';
import 'package:currency_converter/presentation/common/status.dart';
import 'package:currency_converter/presentation/screens/currencies/bloc/currencies_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCurrenciesUseCase extends Mock implements GetCurrenciesUseCase {}

void main() {
  late MockGetCurrenciesUseCase mockGetCurrenciesUseCase;
  late CurrenciesBloc bloc;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockGetCurrenciesUseCase = MockGetCurrenciesUseCase();
    bloc = CurrenciesBloc(mockGetCurrenciesUseCase);
  });

  final currencies = [
    const CurrencyModel(currencyCode: 'USD', name: 'US Dollar'),
    const CurrencyModel(currencyCode: 'EUR', name: 'Euro'),
  ];
  final currenciesModel = CurrenciesModel(currencies);
  final failure = AppUnexpectedException();

  blocTest<CurrenciesBloc, CurrenciesState>(
    'emits [loading, success] when use case returns currencies',
    build: () {
      when(
        () => mockGetCurrenciesUseCase(any()),
      ).thenAnswer((_) async => Right(currenciesModel));
      return bloc;
    },
    act: (bloc) => bloc.add(const CurrenciesFetched()),
    expect: () => [
      const CurrenciesState(status: Status.loading),
      CurrenciesState(status: Status.success, currencies: currenciesModel),
    ],
    verify: (_) {
      verify(() => mockGetCurrenciesUseCase(any())).called(1);
    },
  );

  blocTest<CurrenciesBloc, CurrenciesState>(
    'emits [loading, failure] when use case returns failure',
    build: () {
      when(
        () => mockGetCurrenciesUseCase(any()),
      ).thenAnswer((_) async => Left(failure));
      return bloc;
    },
    act: (bloc) => bloc.add(const CurrenciesFetched()),
    expect: () => [
      const CurrenciesState(status: Status.loading),
      CurrenciesState(status: Status.failure, failure: failure),
    ],
    verify: (_) {
      verify(() => mockGetCurrenciesUseCase(any())).called(1);
    },
  );
}
