import "package:flutter/material.dart";

import "../../../Theme/light_theme.dart";

class CustomTimeSlot extends StatelessWidget {
  final String? title;
  final String? price;
  final bool? isFree;

  const CustomTimeSlot({
    super.key,
    required this.title,
    required this.price,
    this.isFree,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 395,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: isFree ?? false
              ? const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    LightThemeData.primaryLightColor,
                    LightThemeData.secondaryLightColor,
                    LightThemeData.secondaryDarkColor,
                  ],
                )
              : const LinearGradient(colors: [Colors.white,Colors.white]),
          boxShadow: [
            BoxShadow(
              spreadRadius: 4,
              blurRadius: 8,
              color: Colors.black.withValues(alpha: 0.2),
              offset: const Offset(8, 8),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title ?? "",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: Text(
            price ?? "",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
