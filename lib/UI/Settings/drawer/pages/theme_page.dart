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
            },
          ),
          RadioListTile<String>(
            value: "Dark",
            groupValue: _selectedTheme,
            title: const Text("Dark"),
            onChanged: (val) {
              setState(() => _selectedTheme = val!);
            },
          ),
          RadioListTile<String>(
            value: "Extra Dark",
            groupValue: _selectedTheme,
            title: const Text("Extra Dark"),
            onChanged: (val) {
              setState(() => _selectedTheme = val!);
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
                // Save chosen theme (add theme switching logic later)
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
