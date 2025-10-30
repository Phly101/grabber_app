import "package:flutter/material.dart";
import "package:grabber_app/Utils/routes.dart";
import "../../../l10n/app_localizations.dart";

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios,color: theme.colorScheme.onPrimary,),
                title:  Text(AppLocalizations.of(context)!.aboutApp,style:theme.textTheme.titleMedium ,),
                leading: ClipOval(
                  child: Container(
                    color: Colors.grey.shade100,
                    padding: const EdgeInsets.all(12),
                    width: 40,
                    height: 40,
                    child: const ImageIcon(
                      AssetImage("Assets/Icons/Heart.png"),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.aboutScreen);

              },
            ),
          ],
        ),
      ),
    );
  }
}
