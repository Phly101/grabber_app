import 'package:flutter/material.dart';

class KeyValueTile extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  final Color? color;

  const KeyValueTile({
    super.key,
    required this.label,
    required this.value,
    this.bold = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(color: color ?? const Color(0xFF726C6C)),
      ),
      trailing: Text(
        value,
        style: TextStyle(
          color: color ?? const Color(0xFF726C6C),
          fontWeight: bold ? FontWeight.bold : FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
