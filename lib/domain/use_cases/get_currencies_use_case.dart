import 'package:currency_converter/core/custom_types/result.dart';
import 'package:currency_converter/data/models/currencies_model.dart';
import 'package:currency_converter/data/repos/currency/currency_repo.dart';
import 'package:currency_converter/domain/use_cases/use_case.dart';

class GetCurrenciesUseCase implements UseCase<CurrenciesModel, NoParams> {
  const GetCurrenciesUseCase(this.currencyRepo);

  final CurrencyRepo currencyRepo;

  @override
  Result<CurrenciesModel> call(NoParams params) => currencyRepo.getCurrencies();
}
