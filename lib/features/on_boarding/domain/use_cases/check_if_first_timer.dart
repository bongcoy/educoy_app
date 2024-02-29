import 'package:educoy_app/core/use_cases/use_cases.dart';
import 'package:educoy_app/core/utils/typedef.dart';
import 'package:educoy_app/features/on_boarding/domain/repositories/on_boarding_repo.dart';

class CheckIfFirstTimer extends UsecaseWithoutParams<bool> {
  CheckIfFirstTimer(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() => _repo.checkIfFirstTimer();
}
