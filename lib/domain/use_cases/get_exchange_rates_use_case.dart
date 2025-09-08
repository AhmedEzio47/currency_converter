import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/core/custom_types/result.dart';
import 'package:currency_converter/core/extensions/date_formatter.dart';
import 'package:currency_converter/data/repos/currency/currency_repo.dart';
import 'package:currency_converter/domain/entities/exchange_rate_entity.dart';
import 'package:currency_converter/domain/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';

/// This use case gets exchange rates in the past 7 days
///
class GetExchangeRatesUseCase
    implements UseCase<List<ExchangeRateEntity>, ExchangeRatesParams> {
  const GetExchangeRatesUseCase(this.repo);

  final CurrencyRepo repo;

  @override
  Result<List<ExchangeRateEntity>> call(ExchangeRatesParams params) async {
    var rates = <ExchangeRateEntity>[];
    for (var i = 0; i < 7; i++) {
      final date = DateTime.now().subtract(Duration(days: i)).formattedYMD;
      final result = await repo.getExchangeRates(
        base: params.baseCurrency,
        date: date,
      );
      result.fold((l) => Left(AppUnexpectedException()), (r) {
        if (r.rates == null) return Left(AppUnexpectedException());
        final rate = r.rates!.firstWhere(
          (element) => element.targetCurrency == params.targetCurrency,
        );
        rates.add(ExchangeRateEntity.fromModel(rate));
      });
    }
    return Right(rates);
  }
}

class ExchangeRatesParams {
  const ExchangeRatesParams({
    required this.baseCurrency,
    required this.targetCurrency,
  });

  final String baseCurrency;
  final String targetCurrency;
}
