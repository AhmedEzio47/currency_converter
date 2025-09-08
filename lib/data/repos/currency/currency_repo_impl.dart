import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/core/custom_types/result.dart';
import 'package:currency_converter/data/models/currencies_model.dart';
import 'package:currency_converter/data/models/exchange_rates_model.dart';
import 'package:currency_converter/data/repos/currency/currency_repo.dart';
import 'package:currency_converter/network/api_endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_common_package/network_layer.dart';

class CurrencyRepoImpl implements CurrencyRepo {
  const CurrencyRepoImpl(this.networkManager);

  final NetworkManager networkManager;

  @override
  Result<CurrenciesModel> getCurrencies() async {
    try {
      final result = await networkManager.request(
        RouteConfig(
          path: APIEndpoints.currencies.endpoint.path,
          requestType: RequestType.get,
          shouldCacheResponse: true,
          maxCacheAge: APIEndpoints.currencies.endpoint.cacheValidityDuration,
        ),
      );
      return Right(CurrenciesModel.fromJson(result));
    } catch (ex) {
      return Left(AppException.fromException(ex));
    }
  }

  @override
  Result<ExchangeRatesModel> getExchangeRates({
    required String base,
    required String date,
  }) async {
    try {
      const appId = String.fromEnvironment('APP_ID');
      final result = await networkManager.request(
        RouteConfig(
          path: APIEndpoints.exchangeRates.endpoint.path.replaceAll(
            '{date}',
            date,
          ),
          requestType: RequestType.get,
          parameters: {'app_id': appId, 'base': base},
        ),
      );
      return Right(ExchangeRatesModel.fromJson(result));
    } catch (ex) {
      return Left(AppException.fromException(ex));
    }
  }
}
