import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/core/custom_types/result.dart';
import 'package:currency_converter/core/extensions/date_formatting.dart';
import 'package:currency_converter/core/extensions/either_casting.dart';
import 'package:currency_converter/data/repos/currency/currency_repo.dart';
import 'package:currency_converter/domain/entities/exchange_rate_entity.dart';
import 'package:currency_converter/domain/use_cases/parameters/exchange_rates_params.dart';
import 'package:currency_converter/domain/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';

/// This use case gets exchange rates in the past 7 days
///
class GetLastWeekExchangeRatesUseCase
    implements UseCase<List<ExchangeRateEntity>, ExchangeRatesParams> {
  const GetLastWeekExchangeRatesUseCase(this.repo);

  final CurrencyRepo repo;

  @override
  Result<List<ExchangeRateEntity>> call(ExchangeRatesParams params) async {
    var rates = <ExchangeRateEntity>[];
    for (var i = 1; i <= 7; i++) {
      final date = DateTime.now().subtract(Duration(days: i)).formattedYMD;
      final result = await repo.getExchangeRates(
        base: params.baseCurrency,
        date: date,
      );
      if (result.isLeft()) return Left(AppUnexpectedException());
      final rate = result.asRight().rates!.firstWhere(
        (element) => element.targetCurrency == params.targetCurrency,
      );
      rates.add(ExchangeRateEntity.fromModel(rate));
    }
    return Right(rates);
  }
}
