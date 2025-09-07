import 'package:currency_converter/di/blocs_di.dart';
import 'package:currency_converter/di/repo_di.dart';
import 'package:currency_converter/di/use_cases_di.dart';
import 'package:get_it/get_it.dart';

import 'network_di.dart';

GetIt di = GetIt.instance;

Future<void> injectDependencies() async {
  await injectNetworkDependencies();
  injectRepos();
  injectUseCases();
  injectBlocs();
}
