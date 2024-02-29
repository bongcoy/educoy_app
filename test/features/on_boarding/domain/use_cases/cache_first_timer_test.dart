import 'package:dartz/dartz.dart';
import 'package:educoy_app/core/errors/failures.dart';
import 'package:educoy_app/features/on_boarding/domain/repositories/on_boarding_repo.dart';
import 'package:educoy_app/features/on_boarding/domain/use_cases/cache_first_timer.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../repositories/on_boarding_repo_test.dart';

// This test file must be created first before creating
// the use case file (the unit tested in this file)

void main() {
  late OnBoardingRepo repo;
  late CacheFirstTimer usecase;

  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CacheFirstTimer(repo);
  });

  test('should return [OnBoardingRepo.cacheFirstTimer] and return right data',
      () async {
    // 1. Arrange
    when(() => repo.cacheFirstTimer()).thenAnswer(
      (_) async => Left(
        ServerFailure(
          message: 'message',
          statusCode: 500,
        ),
      ),
    );
    // 2. Act
    final result = await usecase();
    // 3. Assert
    expect(
      result,
      equals(
        Left<Failure, dynamic>(
          ServerFailure(message: 'message', statusCode: 500),
        ),
      ),
    );
    verify(() => repo.cacheFirstTimer()).called(1);
    // make sure that we don't have interactions with the dependencies
    verifyNoMoreInteractions(repo);
  });
}
