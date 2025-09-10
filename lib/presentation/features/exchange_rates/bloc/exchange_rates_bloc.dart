import 'package:currency_converter/data/models/exchange_rates_model.dart';
import 'package:currency_converter/domain/entities/exchange_rate_entity.dart';
import 'package:currency_converter/domain/use_cases/get_last_week_exchange_rates_use_case.dart';
import 'package:currency_converter/domain/use_cases/get_today_exchange_rate_use_case.dart';
import 'package:currency_converter/domain/use_cases/parameters/exchange_rates_params.dart';
import 'package:currency_converter/presentation/common/base_state.dart';
import 'package:currency_converter/presentation/common/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exchange_rates_event.dart';
part 'exchange_rates_state.dart';

final class ExchangeRatesBloc
    extends Bloc<ExchangeRatesEvent, ExchangeRatesState> {
  ExchangeRatesBloc({
    required this.getExchangeRatesUseCase,
    required this.getTodayExchangeRateUseCase,
  }) : super(const ExchangeRatesState()) {
    on<ExchangeRatesForLastWeekFetched>(_onExchangeRatesForLastWeekFetched);
    on<ExchangeRatesForTodayFetched>(_onExchangeRatesForTodayFetched);
  }

  final GetLastWeekExchangeRatesUseCase getExchangeRatesUseCase;
  final GetTodayExchangeRateUseCase getTodayExchangeRateUseCase;

  Future<void> _onExchangeRatesForLastWeekFetched(
    ExchangeRatesForLastWeekFetched event,
    Emitter<ExchangeRatesState> emit,
  ) async {
    emit(const ExchangeRatesState(status: Status.loading));
    final result = await getExchangeRatesUseCase(
      const ExchangeRatesParams(baseCurrency: 'USD', targetCurrency: 'EGP'),
    );
    result.fold(
      (l) => emit(ExchangeRatesState(status: Status.failure, failure: l)),
      (r) => emit(
        ExchangeRatesState(
          status: Status.success,
          rates: r,
          baseCurrency: 'USD',
          targetCurrency: 'EGP',
        ),
      ),
    );
  }

  Future<void> _onExchangeRatesForTodayFetched(
    ExchangeRatesForTodayFetched event,
    Emitter<ExchangeRatesState> emit,
  ) async {
    emit(const ExchangeRatesState(status: Status.loading));
    final result = await getTodayExchangeRateUseCase(
      ExchangeRatesParams(baseCurrency: event.baseCurrency),
    );
    result.fold(
      (l) => emit(ExchangeRatesState(status: Status.failure, failure: l)),
      (r) => emit(
        ExchangeRatesState(
          status: Status.success,
          todayExchangeRate: r,
          baseCurrency: event.baseCurrency,
        ),
      ),
    );
  }
}
