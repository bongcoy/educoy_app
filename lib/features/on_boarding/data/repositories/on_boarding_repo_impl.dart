import 'package:dartz/dartz.dart';
import 'package:educoy_app/core/errors/exceptions.dart';
import 'package:educoy_app/core/errors/failures.dart';
import 'package:educoy_app/core/utils/typedef.dart';
import 'package:educoy_app/features/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:educoy_app/features/on_boarding/domain/repositories/on_boarding_repo.dart';

class OnBoardingRepoImpl implements OnBoardingRepo {
  OnBoardingRepoImpl(this._localDataSource);

  final OnBoardingLocalDataSource _localDataSource;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure(message: 'message', statusCode: 500));
    }
  }

  @override
  ResultFuture<bool> checkIfFirstTimer() async {
    try {
      final result = await _localDataSource.checkIfFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
