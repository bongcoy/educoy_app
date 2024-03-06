import 'package:educoy_app/features/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:educoy_app/features/on_boarding/data/repositories/on_boarding_repo_impl.dart';
import 'package:educoy_app/features/on_boarding/domain/repositories/on_boarding_repo.dart';
import 'package:educoy_app/features/on_boarding/domain/use_cases/cache_first_timer.dart';
import 'package:educoy_app/features/on_boarding/domain/use_cases/check_if_first_timer.dart';
import 'package:educoy_app/features/on_boarding/presentation/manager/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // Feature -> OnBoarding
  // Business Logic
  final sharedPreferences = await SharedPreferences.getInstance();

  serviceLocator
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: serviceLocator(),
        checkIfFirstTimer: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTimer(serviceLocator()))
    ..registerLazySingleton(() => CheckIfFirstTimer(serviceLocator()))
    ..registerLazySingleton<OnBoardingRepo>(
      () => OnBoardingRepoImpl(serviceLocator()),
    )
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDSImpl(serviceLocator()),
    )
    ..registerLazySingleton(() => sharedPreferences);
}
