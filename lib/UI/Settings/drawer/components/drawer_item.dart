import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/theme.dart';

class DrawerItem extends StatelessWidget {
  final IconData? icon;
  final Widget? svgIcon;
  final String title;
  final VoidCallback? onTap;
  final Color? iconColor;
  final TextStyle? textStyle;
  final bool showDivider;

  const DrawerItem({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
    this.iconColor,
    this.textStyle,
    this.showDivider = false,
    this.svgIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: svgIcon ?? Icon(
            icon,
            color: iconColor ?? AppColors.textButtonColor,
          ),
          title: Text(
            title,
            style: textStyle ?? const TextStyle(fontSize: 16),
          ),
          onTap: onTap,
        ),
        if (showDivider)  Divider(color: Colors.grey.withValues(alpha: 0.5),),
      ],
    );
  }
}
