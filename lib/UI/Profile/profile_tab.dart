import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:grabber_app/Services/Users/Bloc/user_bloc.dart";
import "package:grabber_app/UI/Profile/widgets/about_app.dart";
import "package:grabber_app/UI/Profile/widgets/content.dart";
import "package:grabber_app/UI/Profile/widgets/profile_header.dart";
import "../../../l10n/app_localizations.dart";

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(const FetchUserData());
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserInitial) {
            showToast(AppLocalizations.of(context)!.loadingProfileData);
          } else if (state is UserUpdateError) {
            showToast(AppLocalizations.of(context)!.failedToLoadProfileData);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileHeader(),
                const SizedBox(height: 16),
                const ProfileContent(),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.more,

                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                const AboutApp(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
