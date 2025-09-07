import 'package:currency_converter/network/api_endpoint.dart';

enum APIEndpoints {
  currencies(
    APIEndpoint(
      path: '/api/currencies.json',
      cacheValidityDuration: Duration(days: 1),
    ),
  );

  const APIEndpoints(this.endpoint);

  final APIEndpoint endpoint;
}
