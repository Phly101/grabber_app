import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _selectedLang = "English"; // default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Language")),
      body: Column(
        children: [
          RadioListTile<String>(
            value: "English",
            groupValue: _selectedLang,
            title: const Text("English"),
            onChanged: (val) {
              setState(() => _selectedLang = val!);
              // TODO: Connect with localization provider or state management (e.g., Bloc, Provider, Riverpod)
            },
          ),
          RadioListTile<String>(
            value: "Arabic",
            groupValue: _selectedLang,
            title: const Text("Arabic"),
            onChanged: (val) {
              setState(() => _selectedLang = val!);
              // TODO: Apply RTL layout direction when Arabic is chosen
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
                // TODO: Persist chosen language (e.g., SharedPreferences, Hive, or app settings)
                // TODO: Reload app or rebuild MaterialApp with new Locale
                Navigator.pop(context); 
              },
              child: const Text("Save"),
            ),
          )
        ],
      ),
    );
  }
}
