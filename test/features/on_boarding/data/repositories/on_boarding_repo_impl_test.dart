import 'package:dartz/dartz.dart';
import 'package:educoy_app/core/errors/exceptions.dart';
import 'package:educoy_app/core/errors/failures.dart';
import 'package:educoy_app/features/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:educoy_app/features/on_boarding/data/repositories/on_boarding_repo_impl.dart';
import 'package:educoy_app/features/on_boarding/domain/repositories/on_boarding_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../data_sources/on_boarding_local_data_source_test.dart';

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepoImpl repoImpl;

  setUp(() {
    localDataSource = MockOnBoardingLocalDataSource();
    repoImpl = OnBoardingRepoImpl(localDataSource);
  });

  test('should be a subclass of [OnBoardingRepo]', () {
    // 1. Arrange
    // 2. Act
    // 3. Assert
    // in repo implementation test, we just check that repoImpl is
    // depends on the repo (from domain layer) itself
    expect(repoImpl, isA<OnBoardingRepo>());
  });

  group('cacheFirstTimer', () {
    test('should complete when call localDataSource is success', () async {
      // 1. Arrange
      when(() => localDataSource.cacheFirstTimer()).thenAnswer(
        (_) async => Future.value(),
      );
      // 2. Act
      final result = await repoImpl.cacheFirstTimer();
      // 3. Assert
      expect(
        result,
        equals(
          const Right<dynamic, void>(null),
        ),
      );
      verify(() => localDataSource.cacheFirstTimer()).called(1);
      // make sure that we don't have interactions with the dependencies
      verifyNoMoreInteractions(localDataSource);

      // Test-Driven Development (TDD) is a coding principle that emphasizes
      // writing test cases before features. TDD involves building a test first
      // and then creating features based on the test results.
    });
    test(
      'should throw a [CacheException] when call localDataSource is unsuccess',
      () async {
        // 1. Arrange
        when(() => localDataSource.cacheFirstTimer()).thenThrow(
          const CacheException(message: 'message'),
        );
        // 2. Act
        final result = await repoImpl.cacheFirstTimer();
        // 3. Assert
        expect(
          result,
          equals(
            Left<CacheFailure, dynamic>(
              CacheFailure(
                message: 'message',
                statusCode: 500,
              ),
            ),
          ),
        );
        verify(() => localDataSource.cacheFirstTimer()).called(1);
        // make sure that we don't have interactions with the dependencies
        verifyNoMoreInteractions(localDataSource);

        // Test-Driven Development (TDD) is a coding principle that emphasizes
        // writing test cases before features. TDD involves building a test first
        // and then creating features based on the test results.
      },
    );
  });

  group('checkIfFirstTimer', () {
    test('should return [true] when user is first timer', () async {
      // 1. Arrange
      when(() => localDataSource.checkIfFirstTimer()).thenAnswer(
        (invocation) => Future.value(true),
      );
      // 2. Act
      final result = await repoImpl.checkIfFirstTimer();
      // 3. Assert
      expect(
        result,
        equals(
          const Right<dynamic, bool>(true),
        ),
      );
      verify(() => localDataSource.checkIfFirstTimer()).called(1);
      // make sure that we don't have interactions with the dependencies
      verifyNoMoreInteractions(localDataSource);

      // Test-Driven Development (TDD) is a coding principle that emphasizes
      // writing test cases before features. TDD involves building a test first
      // and then creating features based on the test results.
    });
    test('should return [false] when user is not first timer', () async {
      // 1. Arrange
      when(() => localDataSource.checkIfFirstTimer()).thenAnswer(
        (invocation) => Future.value(false),
      );
      // 2. Act
      final result = await repoImpl.checkIfFirstTimer();
      // 3. Assert
      expect(
        result,
        equals(
          const Right<dynamic, bool>(false),
        ),
      );
      verify(() => localDataSource.checkIfFirstTimer()).called(1);
      // make sure that we don't have interactions with the dependencies
      verifyNoMoreInteractions(localDataSource);

      // Test-Driven Development (TDD) is a coding principle that emphasizes
      // writing test cases before features. TDD involves building a test first
      // and then creating features based on the test results.
    });
    test(
      'should return [CacheFailure] when call localDataSource is unsuccessful',
      () async {
        // 1. Arrange
        when(() => localDataSource.checkIfFirstTimer()).thenThrow(
          // sc 403 cause it's failed to call localDataSource
          const CacheException(message: 'message', statusCode: 403),
        );
        // 2. Act
        final result = await repoImpl.checkIfFirstTimer();
        // 3. Assert
        expect(
          result,
          equals(
            Left<CacheFailure, dynamic>(
              CacheFailure(
                message: 'message',
                statusCode: 403,
              ),
            ),
          ),
        );
        verify(() => localDataSource.checkIfFirstTimer()).called(1);
        // make sure that we don't have interactions with the dependencies
        verifyNoMoreInteractions(localDataSource);

        // Test-Driven Development (TDD) is a coding principle that emphasizes
        // writing test cases before features. TDD involves building a test first
        // and then creating features based on the test results.
      },
    );
  });
}
