import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/theme.dart';

class AppDrawerFooter extends StatelessWidget {
  final VoidCallback? onLogout;

  const AppDrawerFooter({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.primaryGreen,
              AppColors.secondaryDarkColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.logout,),
          label: const Text("Logout"),
          onPressed: onLogout,
        ),
      ),
    );
  }
}
