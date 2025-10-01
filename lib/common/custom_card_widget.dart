import "package:flutter/material.dart";

class CustomCardWidget extends StatelessWidget {
  final Widget? child;
  final double? elevation;
  final EdgeInsetsGeometry? margin;
  final ShapeBorder? shape;
  final Color? shadowColor;
  final Color? color;
  const CustomCardWidget({super.key, this.child, this.elevation, this.margin, this.shape, this.shadowColor, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: elevation ?? 6,
      margin: margin ?? const EdgeInsets.all(10),
      shape: shape?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor:  Colors.grey.withValues(alpha: 0.5),
      child: child,
    );
  }
}
