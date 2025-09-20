import "package:flutter/material.dart";
import "package:grabber_app/common/gradient_widget_container.dart";

import "../../../Theme/theme.dart";

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientWidgetContainer(
      width: double.infinity,
      height: 89,
      child: Center(
        child: ListTile(
          leading: ClipOval(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(12),
              width: 50,
              height: 50,
              // TODO: Replace static AssetImage with a NetworkImage if user has a profile picture
              child: const ImageIcon(
                AssetImage("Assets/Icons/Profile.png"),
                color: AppColors.black,
              ),
            ),
          ),
          title: Text(
            "Itunuoluwa Abidoye",
            // TODO: Replace with dynamic username from state/provider/auth service
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold, // Added bold for better emphasis
            ),
          ),
          subtitle: Text(
            "@Itunuoluwa",
            // TODO: Replace with dynamic handle/ID
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          trailing: MaterialButton(
            onPressed: () {
              // TODO: Add navigation to settings/profile editing screen
            },
            shape: const CircleBorder(),
            minWidth: 0,
            padding: EdgeInsets.zero,
            child: ImageIcon(
              const AssetImage("Assets/Icons/penIcon.png"),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
