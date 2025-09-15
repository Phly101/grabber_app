import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';

import "../../../l10n/app_localizations.dart";

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 212,
        height: 150,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              LightThemeData.primaryLightColor,
              LightThemeData.secondaryLightColor,
              LightThemeData.secondaryDarkColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
             Text(
              AppLocalizations.of(context)!.areYouSureYouWantToLogout,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: LightThemeData.blackColor,
                fontWeight: FontWeight.bold,
              ),
              // TODO: Localize this text for multi-language support
            ),
            const SizedBox(height: 50),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEA6C6C), // red
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Add logout logic here (clear tokens, clear Hive/SharedPreferences, navigate to login)
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.yes),
                    // TODO: Localize button text
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFD500),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.no),
                    // TODO: Localize button text
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
