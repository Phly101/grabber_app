import "package:flutter/material.dart";

class ProfileItem extends StatelessWidget {
  final String title;
  final String subtitle;
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
          leading: leading ,
          title: Text(
            title,
            style: const TextStyle(
              
              fontWeight: FontWeight.bold,
              
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
