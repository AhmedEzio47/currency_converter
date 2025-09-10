import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/presentation/common/status.dart';
import 'package:currency_converter/presentation/features/coverter/bloc/converter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConverterBloc', () {
    late ConverterBloc bloc;

    setUp(() {
      bloc = ConverterBloc();
    });

    const from = 'USD';
    const to = 'EUR';
    const amount = 10.0;
    const rate = 0.92;
    final converted = amount * rate;

    blocTest<ConverterBloc, ConverterState>(
      'emits state with correct conversion and status on ConversionSubmitted',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const ConversionSubmitted(
          from: from,
          to: to,
          amount: amount,
          rate: rate,
        ),
      ),
      expect: () => [
        ConverterState(
          from: from,
          to: to,
          amount: amount,
          result: converted,
          status: Status.success,
        ),
      ],
    );

    test(
      'throws AssertionError if amount is zero or negative on ConversionSubmitted',
      () {
        expect(
          () => ConversionSubmitted(from: from, to: to, amount: 0, rate: rate),
          throwsA(isA<AssertionError>()),
        );
        expect(
          () => ConversionSubmitted(from: from, to: to, amount: -5, rate: rate),
          throwsA(isA<AssertionError>()),
        );
      },
    );

    blocTest<ConverterBloc, ConverterState>(
      'emits initial state on ConversionReset',
      build: () => bloc,
      act: (bloc) => bloc.add(const ConversionReset()),
      expect: () => [const ConverterState()],
    );
  });
}
