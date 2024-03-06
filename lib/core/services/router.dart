import 'package:educoy_app/core/common/views/under_construction_page.dart';
import 'package:educoy_app/core/services/injection_container.dart';
import 'package:educoy_app/features/on_boarding/presentation/manager/on_boarding_cubit.dart';
import 'package:educoy_app/features/on_boarding/presentation/pages/on_boarding_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  debugPrint('router.dart: ${settings.name}');
  switch (settings.name) {
    case OnBoardingPage.routeName:
      return _pageBuilder(
        (ctx) => BlocProvider(
          create: (_) => serviceLocator<OnBoardingCubit>(),
          child: const OnBoardingPage(),
        ),
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
