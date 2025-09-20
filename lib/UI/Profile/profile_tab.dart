
import "package:flutter/material.dart";
import "package:grabber_app/UI/Profile/widgets/about_app.dart";
import "package:grabber_app/UI/Profile/widgets/content.dart";
import "package:grabber_app/UI/Profile/widgets/profile_header.dart";
import "../../../l10n/app_localizations.dart";





class ProfileTab extends StatelessWidget {
  // TODO: Consider renaming routeName to match app's route naming convention

  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
      // ),
      // TODO: Decide if AppBar is needed (useful if adding settings or back navigation)
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(),

              const SizedBox(height: 16),
              const ProfileContent(),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.more,
                // TODO: Localize "More" for multi-language support
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 10),
              const AboutApp(),
            ],
          ),
        ),
      ),
    );
  }
}
