import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";
import "package:grabber_app/Services/Authentication/bloc/auth_bloc.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/Profile/widgets/change_password_form.dart";
import "package:grabber_app/UI/Profile/widgets/logout_dialog.dart";
import "../../../Services/Users/Bloc/user_bloc.dart";
import "../../../l10n/app_localizations.dart";
import "edit_dialog.dart";
import "profile_item.dart";

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newConfirmPasswordController = TextEditingController();

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
            title: Text(
              AppLocalizations.of(context)!.email,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: BlocSelector<UserBloc, UserState, String>(
              selector: (state) => state.user.email,
              builder: (context, email) {
                return Text(
                  email,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                );
              },
            ),
            leading: ClipOval(
              child: Container(
                color: Colors.grey.shade100,
                padding: const EdgeInsets.all(12),
                width: 50,
                height: 50,
                child: const ImageIcon(
                  AssetImage(
                    "Assets/Icons/Profile.png",
                  ),
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            child: ProfileItem(
              title: Text(
                AppLocalizations.of(context)!.password,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                AppLocalizations.of(context)!.makeChangesToYourAccount,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              trailing: IconButton(
                onPressed: () {
                  final showPasswordChangeForm = ChangePasswordForm(
                    formKey: _formKey,
                    emailController: _emailController,
                    currentPasswordController: _currentPasswordController,
                    newPasswordController: _newPasswordController,
                    confirmPasswordController: _newConfirmPasswordController,
                  );
                  showPasswordChangeForm.showChangePasswordForm(context);
                  _emailController.clear();
                  _currentPasswordController.clear();
                  _newPasswordController.clear();
                  _newConfirmPasswordController.clear();
                  _formKey.currentState!.reset();

                },
                icon: ImageIcon(
                  const AssetImage("Assets/Icons/penIcon.png"),
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              leading: ClipOval(
                child: Container(
                  color: Colors.grey.shade100,
                  padding: const EdgeInsets.all(12),
                  width: 50,
                  height: 50,
                  child: SvgPicture.asset(
                    "Assets/Icons/keyIcon.svg",
                    colorFilter: const ColorFilter.mode(
                      AppColors.black,
                      BlendMode.srcIn,
                    ),
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            ),
          ),
          ProfileItem(
            title: Text(AppLocalizations.of(context)!.phoneNumber),
            subtitle: BlocSelector<UserBloc, UserState, String>(
              selector: (state) => state.user.phoneNumber,
              builder: (context, phoneNumber) {
                return Text(
                  phoneNumber,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                );
              },
            ),
            trailing: MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => EditDialog(
                    field: "phoneNum",
                    currentValue: context
                        .read<UserBloc>()
                        .state
                        .user
                        .phoneNumber,
                  ),
                );
              },
              child: ImageIcon(
                const AssetImage("Assets/Icons/penIcon.png"),
                color: theme.colorScheme.onPrimary,
              ),
            ),
            leading: ClipOval(
              child: Container(
                color: Colors.grey.shade100,
                padding: const EdgeInsets.all(12),
                width: 50,
                height: 50,
                child: SvgPicture.asset(
                  "Assets/Icons/phone.svg",
                  colorFilter: const ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          ),

          ProfileItem(
            title: Text(
              AppLocalizations.of(context)!.logout,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              AppLocalizations.of(context)!.furtherSecureYourAccountForSafety,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            leading: ClipOval(
              child: Container(
                color: Colors.grey.shade100,
                padding: const EdgeInsets.all(12),
                width: 55,
                height: 55,
                child: const Icon(
                  Icons.logout,
                  color: AppColors.black,
                ),
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
