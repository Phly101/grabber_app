import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';

import "../../../../l10n/app_localizations.dart";

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return  DrawerHeader(
      decoration:  const BoxDecoration(
        gradient: LinearGradient(
          colors: [LightThemeData.darkPrimaryColor, LightThemeData.secondaryDarkColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.settings, size: 60,),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.settings,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
