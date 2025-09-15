import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../../../../Blocs/LocaleBloc/localeBloc.dart";
import "../../../../Blocs/LocaleBloc/localeEvent.dart";
import "../../../../Blocs/LocaleBloc/localeState.dart";
import "../../../../l10n/app_localizations.dart";
import "../../../../main.dart";

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  late String _selectedLang ;
  @override
  void initState() {
    super.initState();
    _selectedLang = sharedpref?.getString("lang") ?? "en";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.chooseLanguage)),
      body: BlocBuilder<LocaleBloc,LocaleState>(
        builder: (context, state){
        return Column(
          children: [
            RadioListTile<String>(
              value: "en",
              groupValue: _selectedLang,
              title: Text(AppLocalizations.of(context)!.english),
              onChanged: (val) {
                setState(() => _selectedLang = val!);
              },
            ),
            RadioListTile<String>(
              value: "ar",
              groupValue: _selectedLang,
              title: Text(AppLocalizations.of(context)!.arabic),
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
                onPressed: () async{
                  await sharedpref?.setString("lang", _selectedLang);
                  context.read<LocaleBloc>().add(ChangeLang(Locale(_selectedLang)));
                  // TODO: Persist chosen language (e.g., SharedPreferences, Hive, or app settings)
                  // TODO: Reload app or rebuild MaterialApp with new Locale
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.save),
              ),
            )
          ],
        );}
      ),
    );
  }
}
