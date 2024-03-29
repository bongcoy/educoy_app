import 'package:educoy_app/core/common/manager/user_provider.dart';
import 'package:educoy_app/core/extensions/context_extension.dart';
import 'package:educoy_app/core/res/colours.dart';
import 'package:educoy_app/core/res/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        final image = user?.profilePic == null || user!.profilePic!.isEmpty
            ? null
            : user.profilePic;
        debugPrint(user.toString());
        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: image != null
                  ? NetworkImage(image)
                  : const AssetImage(MediaResource.user) as ImageProvider,
            ),
            const SizedBox(height: 16),
            Text(
              user?.fullName ?? 'No User',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
            // TODO(bongcoy): bio is null. But it's null only in emulator :)
            if (user?.bio != null && user!.bio!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * .15,
                ),
                child: Text(
                  user.bio!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colours.neutralTextColour,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
