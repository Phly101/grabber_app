import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 89,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            LightThemeData.secondaryDarkColor,
            LightThemeData.secondaryLightColor,
            LightThemeData.primaryLightColor,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
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
              ),
            ),
          ),
          title: const Text(
            "Itunuoluwa Abidoye",
            // TODO: Replace with dynamic username from state/provider/auth service
            style: TextStyle(
              color: LightThemeData.primaryLightColor,
              fontWeight: FontWeight.bold, // Added bold for better emphasis
            ),
          ),
          subtitle: const Text(
            "@Itunuoluwa",
            // TODO: Replace with dynamic handle/ID
            style: TextStyle(
              color: LightThemeData.primaryLightColor,
            ),
          ),
          trailing: MaterialButton(
            onPressed: () {
              // TODO: Add navigation to settings/profile editing screen
            },
            shape: const CircleBorder(),
            minWidth: 0,
            padding: EdgeInsets.zero,
            child: const ImageIcon(
              AssetImage("Assets/Icons/Vector.png"),
              color: LightThemeData.primaryLightColor, 
            ),
          ),
        ),
      ),
    );
  }
}
