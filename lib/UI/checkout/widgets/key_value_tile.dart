import "package:flutter/material.dart";

class KeyValueTile extends StatelessWidget {
  final Widget? leading;
  final String label;
  final Widget trailing;
  final Color? color;
  final Color? colorIcon;

  KeyValueTile.text({
    super.key,
    this.leading,
    required this.label,
    required String value,
    this.color, this.colorIcon,
  }) : trailing = Text(
    value,
    style: TextStyle(
      color: color ?? const Color(0xFF726C6C),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  );

  KeyValueTile.icon({
    super.key,
    this.leading,
    required this.label,
    IconData? icon,
    this.color, this.colorIcon, TextStyle? style,
  }) : trailing = Icon(icon, size: 30,color: colorIcon,);

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    return ListTile(
      tileColor: theme.colorScheme.surface,

      leading: leading,
      title: Text(
        label,
        style: TextStyle(color: color ?? const Color(0xFF726C6C)),
      ),
      trailing: trailing,
    );
  }
}