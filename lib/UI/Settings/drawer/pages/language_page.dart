import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/UI/Settings/drawer/components/custom_list_tile.dart";
import "package:grabber_app/l10n/app_localizations.dart";
import "../../../../Blocs/localization/app_locale_bloc.dart";
import "../../../../Blocs/localization/app_locale_event.dart";
import "../../../../Blocs/localization/app_locale_state.dart";

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.chooseLanguage)),
      body: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomListTile(

                  localId: state.langCode,
                  onTap: () {
                    BlocProvider.of<LocaleBloc>(context).add(EnglishLangEvent());
                  },
                  title: AppLocalizations.of(context)!.english,
                  widget: Image.asset(
                    "Assets/Icons/english-language.png",
                    scale: 15,
                  ),
                  iconColors: [Colors.white, Colors.orangeAccent],
                  isLocal: true,
                  id: 0,
                ),
                const SizedBox(height: 20),

                CustomListTile(
                  localId: state.langCode,
                  onTap: () {
                    BlocProvider.of<LocaleBloc>(context).add(ArabicLangEvent());
                  },
                  title: AppLocalizations.of(context)!.arabic,
                  widget: Image.asset(
                    "Assets/Icons/arabic.png",
                    scale: 15,
                  ),
                  iconColors: [Colors.white, Colors.orangeAccent],
                  id: 1,
                  isLocal: true,
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
