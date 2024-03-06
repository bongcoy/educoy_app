import 'package:educoy_app/core/common/views/loading_page.dart';
import 'package:educoy_app/features/on_boarding/presentation/manager/on_boarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  static const routeName = '/';

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer(
        builder: (context, state) {
          if(state is CheckingFirstTimer || state is CachingFirstTimer){
            return const LoadingPage();
          }
          return const Center();
        },
        listener: (context, state) {
          if (state is OnBoardingStatus) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is UserCached) {
            // TODO(bongcoy): Push to the appropriate screen
          }
        },
      ),
    );
  }
}
