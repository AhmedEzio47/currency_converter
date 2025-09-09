import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/data/models/currencies_model.dart';
import 'package:currency_converter/data/models/currency_model.dart';
import 'package:currency_converter/data/repos/currency/currency_repo.dart';
import 'package:currency_converter/domain/use_cases/get_currencies_use_case.dart';
import 'package:currency_converter/domain/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyRepository extends Mock implements CurrencyRepo {}

void main() {
  late GetCurrenciesUseCase sut;
  late MockCurrencyRepository mockCurrencyRepo;

  setUp(() {
    mockCurrencyRepo = MockCurrencyRepository();
    sut = GetCurrenciesUseCase(mockCurrencyRepo);
  });

  final tCurrencies = CurrenciesModel([
    CurrencyModel(currencyCode: 'USD', name: 'US Dollar'),
    CurrencyModel(currencyCode: 'EUR', name: 'Euro'),
  ]);

  test('should get list of currencies from repository', () async {
    // arrange
    when(
      () => mockCurrencyRepo.getCurrencies(),
    ).thenAnswer((_) async => Right(tCurrencies));

    // act
    final result = await sut(NoParams());

    // assert
    expect(result, Right(tCurrencies));
    verify(() => mockCurrencyRepo.getCurrencies()).called(1);
    verifyNoMoreInteractions(mockCurrencyRepo);
  });

  test('should return failure when repository fails', () async {
    // arrange
    when(
      () => mockCurrencyRepo.getCurrencies(),
    ).thenAnswer((_) async => Left(AppUnexpectedException()));

    // act
    final result = await sut(NoParams());

    // assert
    expect(result, isA<Left<AppException, CurrenciesModel>>());
    verify(() => mockCurrencyRepo.getCurrencies()).called(1);
    verifyNoMoreInteractions(mockCurrencyRepo);
  });
}
