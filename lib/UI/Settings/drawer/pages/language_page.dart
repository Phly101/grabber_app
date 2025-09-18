
import "package:flutter/material.dart";
import "package:grabber_app/UI/Settings/drawer/components/custom_list_tile.dart";
import "package:grabber_app/l10n/app_localizations.dart";

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
 // String _selectedLang = "English"; // default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Language")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomListTile(
              themeId: "en",
              onTap: () {},
              title: AppLocalizations.of(context)!.english,
              widget: Image.asset("Assets/Icons/english-language.png",scale: 15,),
              iconColors: [Colors.white, Colors.orangeAccent],
              isLocal: true,
              id: 0,
            ),
            const SizedBox(height: 20),

            CustomListTile(
              themeId: "n",
              onTap: () {},
              title: AppLocalizations.of(context)!.arabic,
              widget: Image.asset("Assets/Icons/arabic.png",scale: 15,),
              iconColors: [Colors.white, Colors.orangeAccent],
              id: 1,
              isLocal: true,
            ),
            const SizedBox(height: 20),


          ],
        ),
      ),

    );
  }
}
