import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:grabber_app/Theme/theme.dart";

class CustomListTile extends StatelessWidget {
  final String title;
  final String themeId;
  final GestureTapCallback onTap;
  final IconData? icons;
  final Widget? widget;
  final List<Color> iconColors;
  final int? id;
  final bool? isLocal;

  const CustomListTile({
    super.key,
    required this.themeId,
    required this.onTap,
    required this.title,
    required this.iconColors,
    this.id,
    this.widget,
    this.icons,
    this.isLocal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.onSecondary.withValues(alpha: 0.2),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
        gradient: (isLocal ?? false) ? _buildGradientLocal(
          id ?? 0,
          themeId,
        ):
        _buildGradient(
          id ?? 0,
          themeId,
        ),
      ),

      child: ListTile(
        onTap: onTap,
        leading:
            widget ??
            FaIcon(icons, color: _getIconColor(id!, themeId, iconColors)),
        title: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

LinearGradient _buildGradient(
  int id,
  String themeId,
) {
  if (id == 0) {
    if (themeId == "L") {
      return const LinearGradient(
        colors: [
          AppColors.primaryLightColor,
          AppColors.secondaryLightColor,
          AppColors.secondaryDarkColor,
        ],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      );
    } else {
      return const LinearGradient(
        colors: [Colors.black, Colors.grey, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  } else if (id == 1) {
    if (themeId == "D") {
      return const LinearGradient(
        colors: [
          AppColors.primaryLightColor,
          AppColors.secondaryLightColor,
          AppColors.secondaryDarkColor,
        ],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      );
    } else {
      return const LinearGradient(
        colors: [Colors.black, Colors.grey, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  return const LinearGradient(colors: [Colors.blue, Colors.purple]);
}

Color _getIconColor(int id, String themeId, List<Color> iconColors) {
  if (id == 0) {
    return themeId == "L" ? iconColors[1] : iconColors[0];
  } else if (id == 1) {
    return themeId == "D" ? iconColors[1] : iconColors[0];
  }

  return iconColors[0];
}

LinearGradient _buildGradientLocal(
  int id,
  String themeId,
) {
  if (id == 0) {
    if (themeId == "en") {
      return const LinearGradient(
        colors: [
          AppColors.primaryLightColor,
          AppColors.secondaryLightColor,
          AppColors.secondaryDarkColor,
        ],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      );
    } else {
      return const LinearGradient(
        colors: [Colors.black, Colors.grey, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  } else if (id == 1) {
    if (themeId == "ar") {
      return const LinearGradient(
        colors: [
          AppColors.primaryLightColor,
          AppColors.secondaryLightColor,
          AppColors.secondaryDarkColor,
        ],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      );
    } else {
      return const LinearGradient(
        colors: [Colors.black, Colors.grey, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  return const LinearGradient(colors: [Colors.blue, Colors.purple]);
}
