import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:grabber_app/Services/Authentication/bloc/auth_bloc.dart";
import "package:grabber_app/UI/Cart/view/Widgets/button_widget.dart";
import "package:grabber_app/Utils/routes.dart";
import "../../../Theme/theme.dart";
import "components/drawer_item.dart";
import "components/drawer_header.dart";
import "components/drawer_footer.dart";
import "../../../l10n/app_localizations.dart";

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignOutLoading) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.LoggingOut,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AuthUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        } else if (state is AuthError) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        return Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              const AppDrawerHeader(),

              // Items
              DrawerItem(
                svgIcon: SvgPicture.asset(
                  "Assets/Icons/languageIcon.svg",
                  colorFilter: const ColorFilter.mode(
                    AppColors.textButtonColor,
                    BlendMode.srcIn,
                  ),
                  width: 25,
                  height: 25,
                ),
                title: AppLocalizations.of(context)!.language,

                showDivider: true,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.language);
                },
              ),
              DrawerItem(
                svgIcon: Image.asset(
                  "Assets/Icons/day-and-night.png",
                  scale: 15,
                  color: AppColors.textButtonColor,
                ),
                title: AppLocalizations.of(context)!.theme,

                showDivider: true,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.theme);
                },
              ),

              const Spacer(),

              // Footer
              AppDrawerFooter(
                onLogout: () {
                  showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(AppLocalizations.of(context)!.logout),
                        content: Text(
                          AppLocalizations.of(
                            context,
                          )!.areYouSureYouWantToLogout,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: ButtonWidget(
                              text: Padding(
                                padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                                child: Text(
                                  AppLocalizations.of(context)!.no,
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              color: Colors.green,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: ButtonWidget(
                              text: Text(
                                AppLocalizations.of(context)!.logout,
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                              color: Colors.red,
                            ),
                          ),
                        ],
                      );
                    },
                  ).then((confirmed) {
                    if (confirmed == true) {
                      context.read<AuthBloc>().add(SignOutRequested());
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
