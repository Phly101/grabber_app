import "package:flutter/material.dart";

class OptionTile extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const OptionTile({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(
          color: const Color(0xFFD1D1D1),
          width: 2.2,
        ),
        borderRadius: BorderRadius.circular(17),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: onTap,
        child: child,
      ),
    );
  }
}
