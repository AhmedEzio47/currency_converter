import 'package:currency_converter/data/models/currencies_model.dart';
import 'package:currency_converter/domain/use_cases/get_currencies_use_case.dart';
import 'package:currency_converter/domain/use_cases/use_case.dart';
import 'package:currency_converter/presentation/common/base_state.dart';
import 'package:currency_converter/presentation/common/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'currencies_event.dart';
part 'currencies_state.dart';

class CurrenciesBloc extends Bloc<CurrenciesEvent, CurrenciesState> {
  CurrenciesBloc(this.getCurrenciesUseCase)
    : super(const CurrenciesState(status: Status.initial)) {
    on<CurrenciesFetched>(_onCurrenciesFetched);
  }

  final GetCurrenciesUseCase getCurrenciesUseCase;

  void _onCurrenciesFetched(
    CurrenciesFetched event,
    Emitter<CurrenciesState> emit,
  ) async {
    emit(const CurrenciesState(status: Status.loading));
    final result = await getCurrenciesUseCase(const NoParams());
    result.fold(
      (l) => emit(CurrenciesState(status: Status.failure, failure: l)),
      (r) => emit(CurrenciesState(status: Status.success, currencies: r)),
    );
  }
}
