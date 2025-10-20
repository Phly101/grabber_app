import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Services/Users/Bloc/user_bloc.dart";
import "package:grabber_app/UI/Profile/widgets/edit_dialog.dart";
import "package:grabber_app/common/gradient_widget_container.dart";

import "../../../Theme/theme.dart";

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientWidgetContainer(
      width: double.infinity,
      height: 89,
      child: Center(
        child: ListTile(
          leading: ClipOval(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(12),
              width: 50,
              height: 50,
              // TODO: Replace static AssetImage with a NetworkImage if user has a profile picture
              child: const ImageIcon(
                AssetImage("Assets/Icons/Profile.png"),
                color: AppColors.black,
              ),
            ),
          ),
          title: BlocSelector<UserBloc, UserState, String>(
            selector: (state) => state.user.name,
            builder: (context, name) {
              return Text(
                name,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          subtitle: BlocSelector<UserBloc, UserState, String>(
            selector: (state) => state.user.email.split("@").first,
            builder: (context, nickName) {
              return Text(
                "@$nickName",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          trailing: MaterialButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => EditDialog(
                  field: "name",
                  currentValue: context.read<UserBloc>().state.user.name,
                ),
              );
            },
            shape: const CircleBorder(),
            minWidth: 0,
            padding: EdgeInsets.zero,
            child: ImageIcon(
              const AssetImage("Assets/Icons/penIcon.png"),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
