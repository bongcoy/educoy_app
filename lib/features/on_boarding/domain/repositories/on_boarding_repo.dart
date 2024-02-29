import 'package:educoy_app/core/utils/typedef.dart';

abstract class OnBoardingRepo {

  OnBoardingRepo();

  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfFirstTimer();
}