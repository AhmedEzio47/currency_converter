import 'package:currency_converter/data/repos/currency/currency_repo.dart';
import 'package:currency_converter/data/repos/currency/currency_repo_impl.dart';

import 'di.dart';

void injectRepos() {
  di.registerFactory<CurrencyRepo>(() => CurrencyRepoImpl(di()));
}
