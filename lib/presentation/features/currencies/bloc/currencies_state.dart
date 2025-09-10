part of 'currencies_bloc.dart';

final class CurrenciesState extends BaseState {
  const CurrenciesState({
    super.status = Status.initial,
    super.failure,
    this.currencies,
  });

  final CurrenciesModel? currencies;

  @override
  List<Object?> get props => super.props..addAll([currencies]);
}
