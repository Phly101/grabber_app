import 'package:flutter/material.dart';

class KeySwitchTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const KeySwitchTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      tileColor: Color(0xFFF6F6F6),
      trailing: Switch(
        value: value,
        activeTrackColor: Color(0xFF0CA201),
        inactiveThumbColor: Colors.white,
        onChanged: onChanged,
      ),
    );
  }
}
