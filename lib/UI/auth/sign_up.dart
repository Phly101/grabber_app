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

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController fullName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  String? selectCity;

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<AppThemeBloc>();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignUpLoading) {
          Fluttertoast.showToast(
            msg: "Signing up...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        } else if (state is AuthAuthenticated) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        } else if (state is AuthError) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
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
                                ATextField(
                                  label: AppLocalizations.of(context)!.fullName,
                                  hint: AppLocalizations.of(
                                    context,
                                  )!.enterYourFullName,
                                  controller: fullName,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.fullNameIsRequired;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                ATextField(
                                  label: AppLocalizations.of(
                                    context,
                                  )!.mobileNumber,
                                  hint: AppLocalizations.of(
                                    context,
                                  )!.enterYourMobileNumber,
                                  controller: mobileNumber,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.mobileNumberIsRequired;
                                    } else if (!RegExp(
                                      r"^01[0-9]{9}$",
                                    ).hasMatch(value)) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.enterAValidNumber;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
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
                                    } else if (!RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                                    ).hasMatch(value)) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.enterAValidEmail;
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
                                const SizedBox(height: 20),
                                ATextField(
                                  label: AppLocalizations.of(
                                    context,
                                  )!.confirmPassword,
                                  hint: AppLocalizations.of(
                                    context,
                                  )!.confirmYourPasswords,
                                  controller: confirmPassword,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.pleaseConfirmYourPassword;
                                    } else if (value != password.text) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.passwordsDoNotMatch;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  AppLocalizations.of(context)!.city,
                                  style: TextStyle(
                                    color: themeBloc.state.appTheme == "L"
                                        ? const Color(0xFF5A5555)
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: selectCity,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                    ),
                                    hint: Text(
                                      AppLocalizations.of(context)!.selectCity,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color:
                                                themeBloc.state.appTheme == "L"
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                    ),

                                    items:
                                        [
                                              AppLocalizations.of(
                                                context,
                                              )!.alexandria,
                                              AppLocalizations.of(
                                                context,
                                              )!.cairo,
                                              AppLocalizations.of(
                                                context,
                                              )!.giza,
                                            ]
                                            .map(
                                              (city) => DropdownMenuItem(
                                                value: city,
                                                child: Text(
                                                  city,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        color:
                                                            themeBloc
                                                                    .state
                                                                    .appTheme ==
                                                                "L"
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectCity = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return AppLocalizations.of(
                                          context,
                                        )!.pleaseSelectACity;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 25),
                                AButton(
                                  text: AppLocalizations.of(context)!.signUp,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(
                                        SignUpRequested(
                                          email: email.text,
                                          password: password.text,
                                          name: fullName.text,
                                          phone: mobileNumber.text,
                                          city: selectCity ?? " ",
                                        ),
                                      );
                                    }
                                  },
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
