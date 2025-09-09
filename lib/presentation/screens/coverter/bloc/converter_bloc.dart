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
    emit(
      ConverterState(
        from: event.from,
        to: event.to,
        amount: event.amount,
        converted: event.amount * event.rate,
        status: Status.success,
      ),
    );
  }

  void _onConversionReset(ConversionReset event, Emitter<ConverterState> emit) {
    emit(const ConverterState());
  }
}
