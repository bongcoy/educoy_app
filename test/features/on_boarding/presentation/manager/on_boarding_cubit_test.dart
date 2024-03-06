import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:educoy_app/core/errors/failures.dart';
import 'package:educoy_app/features/on_boarding/domain/use_cases/cache_first_timer.dart';
import 'package:educoy_app/features/on_boarding/domain/use_cases/check_if_first_timer.dart';
import 'package:educoy_app/features/on_boarding/presentation/manager/on_boarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfFirstTimer extends Mock implements CheckIfFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfFirstTimer checkIfFirstTimer;
  late OnBoardingCubit onBoardingCubit;

  setUp(() {
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfFirstTimer = MockCheckIfFirstTimer();
    onBoardingCubit = OnBoardingCubit(
      cacheFirstTimer: cacheFirstTimer,
      checkIfFirstTimer: checkIfFirstTimer,
    );
  });

  final testFailure = CacheFailure(message: 'message', statusCode: 4032);

  test('initial state should be [OnBoardingInitial]', () {
    expect(onBoardingCubit.state, const OnBoardingInitial());
  });

  group('cacheFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTimer, UserCached] when success',
      build: () {
        when(() => cacheFirstTimer()).thenAnswer(
          (_) async => const Right(null),
        );
        return onBoardingCubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => [
        const CachingFirstTimer(),
        const UserCached(),
      ],
      verify: (_) {
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTimer, OnBoardingError] when unsuccess',
      build: () {
        when(() => cacheFirstTimer()).thenAnswer(
          (_) async => Left(testFailure),
        );
        return onBoardingCubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => [
        const CachingFirstTimer(),
        OnBoardingError(testFailure.message),
      ],
      verify: (_) {
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );

  });

  group('checkIfFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckingFirstTimer, OnBoardingStatus] when success',
      build: () {
        when(() => checkIfFirstTimer()).thenAnswer(
          (_) async => const Right(false),
        );
        return onBoardingCubit;
      },
      act: (cubit) => cubit.checkIfFirstTimer(),
      expect: () => [
        const CheckingFirstTimer(),
        const OnBoardingStatus(isFirstTime: false),
      ],
      verify: (_) {
        verify(() => checkIfFirstTimer()).called(1);
        verifyNoMoreInteractions(checkIfFirstTimer);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckingFirstTimer, OnBoardingStatus(true)] when unsuccess',
      build: () {
        when(() => checkIfFirstTimer()).thenAnswer(
          (_) async => Left(testFailure),
        );
        return onBoardingCubit;
      },
      act: (cubit) => cubit.checkIfFirstTimer(),
      expect: () => [
        const CheckingFirstTimer(),
        const OnBoardingStatus(isFirstTime: true),
      ],
      verify: (_) {
        verify(() => checkIfFirstTimer()).called(1);
        verifyNoMoreInteractions(checkIfFirstTimer);
      },
    );

  });

}
