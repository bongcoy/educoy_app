import 'package:educoy_app/core/common/views/loading_page.dart';
import 'package:educoy_app/core/common/widgets/gradient_background.dart';
import 'package:educoy_app/core/res/colours.dart';
import 'package:educoy_app/core/res/images.dart';
import 'package:educoy_app/features/on_boarding/domain/entities/page_content.dart';
import 'package:educoy_app/features/on_boarding/presentation/manager/on_boarding_cubit.dart';
import 'package:educoy_app/features/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: MediaResource.onBoardingBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          builder: (context, state) {
            if (state is CheckingFirstTimer || state is CachingFirstTimer) {
              return const LoadingPage();
            }
            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: const [
                    OnBoardingBody(pageContent: PageContent.first()),
                    OnBoardingBody(pageContent: PageContent.second()),
                    OnBoardingBody(pageContent: PageContent.third()),
                  ],
                ),
                Align(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 40,
                      activeDotColor: Colours.primaryColour,
                      dotColor: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
          listener: (context, state) {
            if (state is OnBoardingStatus) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is UserCached) {
              // TODO(bongcoy): Push to the appropriate screen
            }
          },
        ),
      ),
    );
  }
}
