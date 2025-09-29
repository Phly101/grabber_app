import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/Profile/widgets/logout_dialog.dart";
import "../../../l10n/app_localizations.dart";
import "profile_item.dart";

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 466,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileItem(
            title: AppLocalizations.of(context)!.email,
            subtitle: AppLocalizations.of(context)!.userExample,
            // TODO: Replace with dynamic user email from state management / backend
            leading: ClipOval(
              child: Container(
                color: Colors.grey.shade100,
                padding: const EdgeInsets.all(12),
                width: 50,
                height: 50,
                child: const ImageIcon(
                  AssetImage("Assets/Icons/Profile.png",),
                  color: AppColors.black,),
                // TODO: Replace static asset with user profile picture
              ),
            ),

          ),
          ProfileItem(

            title: AppLocalizations.of(context)!.password,
            subtitle: AppLocalizations.of(context)!.makeChangesToYourAccount,
            trailing: MaterialButton(
              onPressed: () {
                // TODO: Implement password reset/change functionality
              },
              child:  ImageIcon(const AssetImage("Assets/Icons/penIcon.png"),color: theme.colorScheme.onPrimary,),
            ),
            leading: ClipOval(
              child: Container(
                color:  Colors.grey.shade100,
                padding: const EdgeInsets.all(12),
                width: 50,
                height: 50,
                child: SvgPicture.asset(
                "Assets/Icons/keyIcon.svg",
                colorFilter:  const ColorFilter.mode(
                   AppColors.black,
                  BlendMode.srcIn,
                ),
                width: 25,
                height: 25,
              ),
              ),
            ),
            onTap: () {
              // TODO: Navigate to password update screen
            },
          ),
          ProfileItem(
            title: AppLocalizations.of(context)!.logout,
            subtitle: AppLocalizations.of(context)!.furtherSecureYourAccountForSafety,
            leading: ClipOval(
              child: Container(
                color: Colors.grey.shade100,
                padding: const EdgeInsets.all(12),
                width: 55,
                height: 55,
                child:  const Icon(Icons.logout,color: AppColors.black ,),
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const LogoutDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}
