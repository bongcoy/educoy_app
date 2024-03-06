import 'package:educoy_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
            context.theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
