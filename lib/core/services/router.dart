import 'package:educoy_app/core/common/views/under_construction_page.dart';
import 'package:educoy_app/core/services/injection_container.dart';
import 'package:educoy_app/features/auth/data/models/local_user_model.dart';
import 'package:educoy_app/features/auth/presentation/manager/auth_bloc.dart';
import 'package:educoy_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:educoy_app/features/home/presentation/pages/home_page.dart';
import 'package:educoy_app/features/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:educoy_app/features/on_boarding/presentation/manager/on_boarding_cubit.dart';
import 'package:educoy_app/features/on_boarding/presentation/pages/on_boarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    default:
      return _pageBuilder(
            (_) => const UnderConstructionPage(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, _, __) => page(context),
    transitionsBuilder: (_, animation, __, child) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
    settings: settings,
  );
}
