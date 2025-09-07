import 'package:flutter_common_package/network_layer.dart';

import 'di.dart' show di;

Future<void> injectNetworkDependencies() async {
  di.registerSingleton<NetworkManager>(NetworkManager.instance);
  await di<NetworkManager>().configure(
    GlobalNetworkConfig(baseUrl: 'https://openexchangerates.org'),
  );
}
