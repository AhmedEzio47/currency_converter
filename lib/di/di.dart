import 'package:currency_converter/di/repo_di.dart';
import 'package:get_it/get_it.dart';

import 'network_di.dart';

GetIt di = GetIt.instance;

Future<void> injectDependencies() async {
  await injectNetworkDependencies();
  injectRepos();
}
