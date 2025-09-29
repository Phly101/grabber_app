import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Services/Authentication/bloc/auth_bloc.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:grabber_app/common/gradient_widget_container.dart";
import "../../l10n/app_localizations.dart";
import "components/button.dart";
import "components/text_field.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<AppThemeBloc>();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignInLoading) {
          Fluttertoast.showToast(
            msg: "Logging in ...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AuthAuthenticated) {
          Fluttertoast.showToast(
            msg: "Login successful 🎉",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          Navigator.pushReplacementNamed(context, AppRoutes.mainApp);
        } else if (state is AuthForgotPassword) {
          Fluttertoast.showToast(
            msg: "Password reset email sent successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AuthError) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: GradientWidgetContainer(
            width: double.infinity,
            height: double.infinity,

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Column(
                      children: [
                        themeBloc.state.appTheme == "L"
                            ? Image.asset("Assets/Images/Grabber222.png")
                            : Image.asset("Assets/Images/GrabberLogoDark.png"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 50),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.welcomeBackToGrabber,
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(
                                        color: themeBloc.state.appTheme == "L"
                                            ? const Color(0xFF5A5555)
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.pleaseSignInWithYourMail,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: themeBloc.state.appTheme == "L"
                                            ? const Color(0xFF5A5555)
                                            : Colors.white.withValues(
                                                alpha: 0.5,
                                              ),
                                      ),
                                ),
                                const SizedBox(height: 40),
                                ATextField(
                                  label: AppLocalizations.of(
                                    context,
                                  )!.emailAddress,
                                  hint: AppLocalizations.of(
                                    context,
                                  )!.enterYourEmailAddress,
                                  controller: email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.emailIsRequired;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                ATextField(
                                  label: AppLocalizations.of(context)!.password,
                                  hint: AppLocalizations.of(
                                    context,
                                  )!.enterYourPassword,
                                  controller: password,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.passwordIsRequired;
                                    }
                                    if (value.length < 8) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.passwordMustBeAtLeast8Characters;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      context.read<AuthBloc>().add(
                                        ForgotPasswordRequested(
                                          email: email.text,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.forgotPassword,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40),

                                // login button
                                AButton(
                                  text: AppLocalizations.of(context)!.login,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(
                                        SignInRequested(
                                          email: email.text,
                                          password: password.text,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.dontHaveAnAccount,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          AppRoutes.signUp,
                                        );
                                      },
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.createAccount,
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 19,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
