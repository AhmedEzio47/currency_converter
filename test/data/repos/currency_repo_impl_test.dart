import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/data/models/currencies_model.dart';
import 'package:currency_converter/data/models/currency_model.dart';
import 'package:currency_converter/data/models/exchange_rate_model.dart';
import 'package:currency_converter/data/models/exchange_rates_model.dart';
import 'package:currency_converter/data/repos/currency/currency_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_common_package/network_layer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworkManager extends Mock implements NetworkManager {}

void main() {
  late MockNetworkManager network;
  late CurrencyRepoImpl sut;

  setUpAll(() {
    registerFallbackValue(RouteConfig(path: '', requestType: RequestType.get));
  });

  setUp(() {
    network = MockNetworkManager();
    sut = CurrencyRepoImpl(network);
  });

  group('getCurrencies', () {
    const currencies = CurrenciesModel(<CurrencyModel>[
      CurrencyModel(currencyCode: 'USD', name: 'United States Dollar'),
    ]);

    test('should return currency list when successful', () async {
      /// arrange
      when(() => network.request(any())).thenAnswer(
        (_) async => <String, dynamic>{'USD': 'United States Dollar'},
      );

      /// act
      final result = await sut.getCurrencies();

      /// assert
      expect(result, const Right<AppException, CurrenciesModel>(currencies));
      verify(() => network.request(any())).called(1);
      verifyNoMoreInteractions(network);
    });

    test(
      'should return AppServerException when call is unsuccessful',
      () async {
        /// arrange
        when(
          () => network.request(any()),
        ).thenThrow(const DefaultAppServerException());

        /// act
        final result = await sut.getCurrencies();

        /// assert
        verify(() => network.request(any())).called(1);
        expect(result, isA<Left<AppException, CurrenciesModel>>());
        verifyNoMoreInteractions(network);
      },
    );
  });

  group('getExchangeRates', () {
    const base = 'USD';
    const exchangeRate = ExchangeRatesModel(
      baseCurrency: 'USD',
      rates: [ExchangeRateModel(targetCurrency: 'EUR', rate: 0.85)],
    );

    test('should return exchange rates when successful', () async {
      /// arrange
      when(() => network.request(any())).thenAnswer(
        (_) async => <String, dynamic>{
          'base': 'USD',
          'rates': {'EUR': 0.85},
        },
      );

      /// act
      final result = await sut.getExchangeRates(base: base, date: '2025-09-09');

      /// assert
      expect(result, Right<AppException, ExchangeRatesModel>(exchangeRate));
      verify(() => network.request(any())).called(1);
      verifyNoMoreInteractions(network);
    });

    test(
      'should return AppServerException when call is unsuccessful',
      () async {
        /// arrange
        when(
          () => network.request(any()),
        ).thenThrow(const DefaultAppServerException());

        /// act
        final result = await sut.getExchangeRates(
          base: base,
          date: '2025-09-09',
        );

        /// assert
        verify(() => network.request(any())).called(1);
        expect(result, isA<Left<AppException, ExchangeRatesModel>>());
        verifyNoMoreInteractions(network);
      },
    );
  });
}
