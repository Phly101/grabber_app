import "package:flutter/material.dart";
import "../../../../l10n/app_localizations.dart";

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  String _selectedTheme = "Light"; // default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.chooseTheme)),
      body: Column(
        children: [
          RadioListTile<String>(
            value: "Light",
            groupValue: _selectedTheme,
            title: Text(AppLocalizations.of(context)!.light),
            onChanged: (val) {
              setState(() => _selectedTheme = val!);
              // TODO: Connect to ThemeProvider or state management solution
            },
          ),
          RadioListTile<String>(
            value: "Dark",
            groupValue: _selectedTheme,
            title: Text(AppLocalizations.of(context)!.dark),
            onChanged: (val) {
              setState(() => _selectedTheme = val!);
              // TODO: Apply dark theme immediately
            },
          ),
          RadioListTile<String>(
            value: "Extra Dark",
            groupValue: _selectedTheme,
            title: Text(AppLocalizations.of(context)!.extraDark),
            onChanged: (val) {
              setState(() => _selectedTheme = val!);
              // TODO: Create and apply a custom "Extra Dark" theme
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                // TODO: Save selected theme to persistent storage (e.g., SharedPreferences, Hive)
                // TODO: Trigger MaterialApp theme rebuild with the new theme
                Navigator.pop(context); 
              },
              child: Text(AppLocalizations.of(context)!.apply),
            ),
          )
        ],
      ),
    );
  }
}
