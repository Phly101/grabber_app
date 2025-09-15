import 'package:flutter/material.dart';

import "../../l10n/app_localizations.dart";

class SettingsTab extends StatelessWidget {
  static const String routeName = "Settings_tab";
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppLocalizations.of(context)!.settingsTab),
    );
  }
}
