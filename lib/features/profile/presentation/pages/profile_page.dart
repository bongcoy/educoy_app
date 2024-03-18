import 'package:educoy_app/core/common/widgets/gradient_background.dart';
import 'package:educoy_app/core/res/images.dart';
import 'package:educoy_app/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:educoy_app/features/profile/presentation/widgets/profile_body.dart';
import 'package:educoy_app/features/profile/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: const ProfileAppBar(),
      body: GradientBackground(
        image: MediaResource.profileGradientBackground,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            ProfileHeader(),
            ProfileBody(),
          ],
        ),
      ),
    );
  }
}
