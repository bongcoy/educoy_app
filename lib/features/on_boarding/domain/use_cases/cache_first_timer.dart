// Use Case is always depends on repositories

import 'package:educoy_app/core/use_cases/use_cases.dart';
import 'package:educoy_app/core/utils/typedef.dart';
import 'package:educoy_app/features/on_boarding/domain/repositories/on_boarding_repo.dart';

class CacheFirstTimer extends UsecaseWithoutParams<void> {
  CacheFirstTimer(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<void> call() => _repo.cacheFirstTimer();
}
