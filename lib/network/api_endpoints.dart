import 'package:currency_converter/network/api_endpoint.dart';

enum APIEndpoints {
  currencies(
    APIEndpoint(
      path: '/api/currencies.json',
      cacheValidityDuration: Duration(days: 1),
    ),
  ),
  exchangeRates(APIEndpoint(path: '/api/historical/{date}.json'));

  const APIEndpoints(this.endpoint);

  final APIEndpoint endpoint;
}
