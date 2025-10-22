import "package:flutter/material.dart";

class ProfileItem extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ProfileItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
        ),
      ),
    );
  }
}

