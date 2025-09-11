import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';
import 'package:grabber_app/UI/Profile/widgets/logout_dialog.dart';

import 'profile_item.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 466, 
      decoration: BoxDecoration(
        color: LightThemeData.surfaceColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileItem(
            title: "Email",
            subtitle: "user@example.com", 
            // TODO: Replace with dynamic user email from state management / backend
            leading: ClipOval(
              child: Container(
                color: Colors.grey.shade100,
                padding: const EdgeInsets.all(12),
                width: 50,
                height: 50,
                child: const ImageIcon(
                  AssetImage("Assets/Icons/Profile.png"),
                ),
                // TODO: Replace static asset with user profile picture
              ),
            ),
            onTap: () {
              // TODO: Navigate to email change/update screen
            },
          ),
          ProfileItem(
            title: "Password",
            subtitle: "Make changes to your account",
            trailing: MaterialButton(
              onPressed: () {
                // TODO: Implement password reset/change functionality
              },
              child: const ImageIcon(AssetImage("Assets/Icons/Vector.png")),
            ),
            leading: ClipOval(
              child: Container(
                color: LightThemeData.surfaceColor,
                padding: const EdgeInsets.all(12),
                width: 50,
                height: 50,
              ),
            ),
            onTap: () {
              // TODO: Navigate to password update screen
            },
          ),
          ProfileItem(
            title: "Logout",
            subtitle: "Further secure your account for safety",
            leading: ClipOval(
              child: Container(
                color: Colors.grey.shade100,
                padding: const EdgeInsets.all(12),
                width: 50,
                height: 50,
                child: const Icon(Icons.logout),
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const LogoutDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}
