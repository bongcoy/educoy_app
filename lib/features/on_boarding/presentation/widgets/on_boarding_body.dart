import 'package:educoy_app/core/extensions/context_extension.dart';
import 'package:educoy_app/features/on_boarding/domain/entities/page_content.dart';
import 'package:flutter/material.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({required this.pageContent, super.key});

  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          pageContent.image,
          height: context.height * .4,
        ),
      ],
    );
  }
}
