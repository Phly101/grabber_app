import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? iconColor;
  final TextStyle? textStyle;
  final bool showDivider; 

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor,
    this.textStyle,
    this.showDivider = false, 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: iconColor ?? LightThemeData.darkPrimaryColor),
          title: Text(
            title,
            style: textStyle ?? const TextStyle(fontSize: 16),
          ),
          onTap: onTap,
        ),
        if (showDivider) const Divider(), 
      ],
    );
  }
}
