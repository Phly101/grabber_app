import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text("Choose Theme")),
      body: Column(
        children: [
          RadioListTile<String>(
            value: "Light",
            groupValue: _selectedTheme,
            title: const Text("Light"),
            onChanged: (val) {
              setState(() => _selectedTheme = val!);
              // TODO: Connect to ThemeProvider or state management solution
            },
          ),
          RadioListTile<String>(
            value: "Dark",
            groupValue: _selectedTheme,
            title: const Text("Dark"),
            onChanged: (val) {
              setState(() => _selectedTheme = val!);
              // TODO: Apply dark theme immediately
            },
          ),
          RadioListTile<String>(
            value: "Extra Dark",
            groupValue: _selectedTheme,
            title: const Text("Extra Dark"),
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
              child: const Text("Apply"),
            ),
          )
        ],
      ),
    );
  }
}
