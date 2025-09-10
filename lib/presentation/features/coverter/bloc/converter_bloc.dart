import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/presentation/common/base_state.dart';
import 'package:currency_converter/presentation/common/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'converter_event.dart';
part 'converter_state.dart';

final class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  ConverterBloc() : super(const ConverterState()) {
    on<ConversionSubmitted>(_onConversionSubmitted);
    on<ConversionReset>(_onConversionReset);
  }

  void _onConversionSubmitted(
    ConversionSubmitted event,
    Emitter<ConverterState> emit,
  ) {
    if (event.amount <= 0) {
      emit(
        ConverterState(
          status: Status.failure,
          failure: AppInvalidInputException('Amount must be greater than zero'),
        ),
      );
    }
    emit(
      ConverterState(
        from: event.from,
        to: event.to,
        amount: event.amount,
        result: event.amount * event.rate,
        status: Status.success,
      ),
    );
  }

  void _onConversionReset(ConversionReset event, Emitter<ConverterState> emit) {
    emit(const ConverterState());
  }
}
