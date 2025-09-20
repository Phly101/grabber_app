import "package:flutter/material.dart";

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
    final theme = Theme.of(context);
    return ListTile(

      title: Text(label),
      tileColor: theme.colorScheme.surface,
      trailing: Switch(
        value: value,
        activeTrackColor: const Color(0xFF0CA201),
        inactiveThumbColor: Colors.white,
        onChanged: onChanged,
      ),
    );
  }
}
