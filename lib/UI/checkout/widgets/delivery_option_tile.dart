import "package:flutter/material.dart";

class DeliveryOptionTile extends StatelessWidget {
  final String value;
  final String icon;
  final String title;
  final String? groupValue;
  final ValueChanged<String?> onChanged;
  final bool showDivider;

  const DeliveryOptionTile({
    super.key,
    required this.value,
    required this.icon,
    required this.title,
    required this.groupValue,
    required this.onChanged,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
      final theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          tileColor: theme.colorScheme.surface,

          title: Text(title),
          leading: Image.asset(icon,color: theme.colorScheme.onPrimary,),
          trailing: Radio(
            value: value,
            groupValue: groupValue,
            activeColor: const Color(0xFF0CA201),
            onChanged: onChanged,
          ),
          onTap: () => onChanged(value),
        ),
        if (showDivider)
          const Divider(height: 1, thickness: 2, color: Color(0xFFECECEC)),
      ],
    );
  }
}