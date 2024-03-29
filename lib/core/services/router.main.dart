part of 'router.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  debugPrint('router.dart: ${settings.name}');
  switch (settings.name) {
    case OnBoardingPage.routeName:
      final prefs = serviceLocator<SharedPreferences>();
      return _pageBuilder(
        (ctx) {
          if (prefs.getBool(keySharedPreferences) ?? true) {
            return BlocProvider(
              create: (_) => serviceLocator<OnBoardingCubit>(),
              child: const OnBoardingPage(),
            );
          } else if (serviceLocator<FirebaseAuth>().currentUser != null) {
            final user = serviceLocator<FirebaseAuth>().currentUser!;
            final localUser = LocalUserModel(
              uid: user.uid,
              email: user.email ?? '',
              points: 0,
              fullName: user.displayName ?? '',
            );
            ctx.userProvider.initUser(localUser);
            return const HomePage();
          }
          return BlocProvider(
            create: (_) => serviceLocator<AuthBloc>(),
            child: const SignInPage(),
          );
        },
        settings: settings,
      );
    case SignInPage.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
          child: const SignInPage(),
        ),
        settings: settings,
      );
    case SignUpPage.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
          child: const SignUpPage(),
        ),
        settings: settings,
      );
    case HomePage.routeName:
      return _pageBuilder(
        (_) => const HomePage(),
        settings: settings,
      );
    // This builder not causing the error (conflicted 'AuthProvider' import).
    // Even though this builder called fui, apparently that wasn't the case.
    // UPDATE: the solution is upgrade the fui version, but we have deleted
    // youtube_metadata package cause its dependencies prevent fui to upgrade
    case '/forgot-password':
      return _pageBuilder(
        (_) => const fui.ForgotPasswordScreen(),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const UnderConstructionPage(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, _, __) => page(context),
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    settings: settings,
  );
}
