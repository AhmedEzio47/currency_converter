import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/core/custom_types/result.dart';
import 'package:currency_converter/core/extensions/date_formatter.dart';
import 'package:currency_converter/data/models/exchange_rates_model.dart';
import 'package:currency_converter/data/repos/currency/currency_repo.dart';
import 'package:currency_converter/domain/use_cases/parameters/exchange_rates_params.dart';
import 'package:currency_converter/domain/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';

class GetTodayExchangeRateUseCase
    implements UseCase<ExchangeRatesModel, ExchangeRatesParams> {
  const GetTodayExchangeRateUseCase(this.repo);

  final CurrencyRepo repo;

  @override
  Result<ExchangeRatesModel> call(ExchangeRatesParams params) async {
    final result = await repo.getExchangeRates(
      base: params.baseCurrency,
      date: DateTime.now().formattedYMD,
    );
    return result.fold((l) => Left(AppUnexpectedException()), (r) {
      return Right(r);
    });
  }
}
