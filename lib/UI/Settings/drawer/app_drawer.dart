import 'package:flutter/material.dart';
import 'pages/language_page.dart';
import 'pages/theme_page.dart';
import 'components/drawer_item.dart';
import 'components/drawer_header.dart';
import 'components/drawer_footer.dart';

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
            icon: Icons.language,
            title: "Language",
            showDivider: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LanguagePage()),
              );
            },
          ),
          DrawerItem(
            icon: Icons.brightness_6,
            title: "Theme",
            showDivider: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ThemePage()),
              );
            },
          ),

          const Spacer(),

          // Footer
          AppDrawerFooter(
            
            onLogout: () {
              
            },
          ),
        ],
      ),
    );
  }
}
