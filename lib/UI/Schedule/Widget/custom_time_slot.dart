import "package:flutter/material.dart";

import "package:grabber_app/common/gradient_widget_container.dart";


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

      child: GradientWidgetContainer(
        width: 395,
        height: 65,
        enableGradient: isFree ?? false,

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
