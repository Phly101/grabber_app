import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";

import "package:grabber_app/l10n/app_localizations.dart";

import "../components/custom_list_tile.dart";

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(AppLocalizations.of(context)!.chooseTheme)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AppThemeBloc, AppThemeState>(
              builder: (context, state) {
                return CustomListTile(
                  themeId: state.appTheme?? "L",
                  onTap: () {
                    BlocProvider.of<AppThemeBloc>(context).add(LightEvent());
                  },
                  title: AppLocalizations.of(context)!.light,
                  icons: FontAwesomeIcons.solidSun,
                  iconColors: [Colors.white, Colors.orangeAccent],
                  id: 0,
                  isLocal: false,
                );
              },
            ),
            const SizedBox(height: 20),

            BlocBuilder<AppThemeBloc, AppThemeState>(
              builder: (context, state) {
                return CustomListTile(
                  themeId:state.appTheme?? "L",
                  onTap: () {
                    BlocProvider.of<AppThemeBloc>(context).add(DarkEvent());
                  },
                  isLocal: false,
                  title: AppLocalizations.of(context)!.dark,
                  icons: FontAwesomeIcons.moon,
                  iconColors: [Colors.white, Colors.orangeAccent],
                  id: 1,
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
