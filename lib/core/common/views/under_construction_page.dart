import 'package:educoy_app/core/common/widgets/gradient_background.dart';
import 'package:educoy_app/core/res/images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnderConstructionPage extends StatelessWidget {
  const UnderConstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: MediaResource.onBoardingBackground,
        child: Lottie.asset(MediaResource.underConstructionPage),
      ),
    );
  }
}
