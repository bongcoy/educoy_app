part of 'injection_container.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
}

Future<void> _initAuth() async {
  serviceLocator
    ..registerFactory(
          () => AuthBloc(
        signIn: serviceLocator(),
        signUp: serviceLocator(),
        forgotPassword: serviceLocator(),
        updateUser: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => SignIn(serviceLocator()))
    ..registerLazySingleton(() => SignUp(serviceLocator()))
    ..registerLazySingleton(() => ForgotPassword(serviceLocator()))
    ..registerLazySingleton(() => UpdateUser(serviceLocator()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(serviceLocator()))
    ..registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(
        authClient: serviceLocator(),
        cloudStoreClient: serviceLocator(),
        dbClient: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}


Future<void> _initOnBoarding() async {
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
