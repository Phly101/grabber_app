import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:grabber_app/Utils/routes.dart";
import "../../../Theme/theme.dart" show AppColors;
import "pages/language_page.dart";
import "pages/theme_page.dart";
import "components/drawer_item.dart";
import "components/drawer_header.dart";
import "components/drawer_footer.dart";

import "../../../l10n/app_localizations.dart";

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          const AppDrawerHeader(),

          // Items
          DrawerItem(
            svgIcon: SvgPicture.asset(
              "Assets/Icons/languageIcon.svg",
              colorFilter: const ColorFilter.mode(
                AppColors.textButtonColor,
                BlendMode.srcIn,
              ),
              width: 25,
              height: 25,
            ),
            title: AppLocalizations.of(context)!.language,

            showDivider: true,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.theme);
            },
          ),
          DrawerItem(
            svgIcon: Image.asset(
              "Assets/Icons/day-and-night.png",
              scale: 15,
              color: AppColors.textButtonColor,
            ),
            title: AppLocalizations.of(context)!.theme,

            showDivider: true,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.theme);
            },
          ),

          const Spacer(),

          // Footer
          AppDrawerFooter(
            onLogout: () {
              Navigator.popAndPushNamed(context, AppRoutes.login);
              // TODO: Implement logout logic (clear user session, tokens, etc.)
              // TODO: Show confirmation dialog before logging out
              // Example: showDialog(context: context, builder: (_) => LogoutDialog()); // نفس اللى فى صفحة البروفايل يعنى
            },
          ),
        ],
      ),
    );
  }
}
