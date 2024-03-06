import 'package:bloc/bloc.dart';
import 'package:educoy_app/features/on_boarding/domain/use_cases/cache_first_timer.dart';
import 'package:educoy_app/features/on_boarding/domain/use_cases/check_if_first_timer.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimer cacheFirstTimer,
    required CheckIfFirstTimer checkIfFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkIfFirstTimer = checkIfFirstTimer,
        super(const OnBoardingInitial());

  // use cases
  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfFirstTimer _checkIfFirstTimer;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());
    final result = await _cacheFirstTimer();
    // use emit to notifies widget when state changes
    result.fold(
      (l) => emit(OnBoardingError(l.message)),
      (r) => emit(const UserCached()),
    );
  }

  Future<void> checkIfFirstTimer() async {
    emit(const CheckingFirstTimer());
    final result = await _checkIfFirstTimer();
    // use emit to notifies widget when state changes
    result.fold(
          (l) => emit(const OnBoardingStatus(isFirstTime: true)),
          (r) => emit(OnBoardingStatus(isFirstTime: r)),
    );
  }
}
