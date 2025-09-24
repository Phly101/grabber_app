import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/Utils/routes.dart";
import "../../../l10n/app_localizations.dart";

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final blocTheme = context.read<AppThemeBloc>();
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, AppRoutes.profile);
          },
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onPrimary),
        ),
        title: Text(
          "Grabber",
          style: theme.textTheme.titleLarge!.copyWith(color: AppColors.white),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.green[600],
                  child: Image.asset("Assets/Images/Logo 1@3x.png"),
                ),
                const SizedBox(height: 12),
                Text(
                  "Grabber",
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: blocTheme.state.appTheme == "L"
                        ? AppColors.textButtonColor
                        : AppColors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Version 1.0.0",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.green,
                          size: 28,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Grabber" ,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      loc.appDescriptionLine1,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      loc.appDescriptionLine2,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      loc.appDescriptionLine3,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.green),
                    title: Text(loc.developedBy),
                    subtitle: const Text("MSB"),
                  ),
                  Divider(height: 0, color: theme.colorScheme.onPrimary),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ListTile(
                      leading: const Icon(Icons.email, color: Colors.green),
                      title: Text(loc.developerEmail),
                      subtitle: const Text("basel.10@gmail.com"),
                    ),
                  ),
                  Divider(height: 0, color: theme.colorScheme.onPrimary),
                  ListTile(
                    leading: const Icon(Icons.public, color: Colors.green),
                    title: Text(loc.website),
                    subtitle: const Text("www.grabber.com"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.article_outlined, color: Colors.white),
              label: Text(
                loc.viewOpenSourceLicenses,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: AppColors.white,
                ),
              ),
              onPressed: () {
                showLicensePage(
                  context: context,
                  applicationName: "Grabber",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "© 2025 Grabber. All rights reserved.",
                );
              },
            ),
            const SizedBox(height: 30),

            Text(
              "© 2025 Grabber. All rights reserved.",
              style: theme.textTheme.bodyLarge!.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
