import "package:flutter/material.dart";
import "../../Theme/light_theme.dart";
import "../../l10n/app_localizations.dart";
import "../main_app/main_screen.dart";
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
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              LightThemeData.primaryLightColor,
              LightThemeData.secondaryLightColor,
              LightThemeData.secondaryDarkColor,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Components(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Column(
                  children: [
                    Image.asset("Assets/Images/Grabber.png"),
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
                              hint: AppLocalizations.of(context)!.enterYourFullName,
                              controller: fullName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.fullNameIsRequired;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ATextField(
                              label: AppLocalizations.of(context)!.mobileNumber,
                              hint: AppLocalizations.of(context)!.enterYourMobileNumber,
                              controller: mobileNumber,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.mobileNumberIsRequired;
                                } else if (!RegExp(
                                  r"^01[0-9]{9}$",
                                ).hasMatch(value)) {
                                  return AppLocalizations.of(context)!.enterAValidNumber;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ATextField(
                              label: AppLocalizations.of(context)!.emailAddress,
                              hint: AppLocalizations.of(context)!.enterYourEmailAddress,
                              controller: email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.emailIsRequired;
                                } else if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                                ).hasMatch(value)) {
                                  return AppLocalizations.of(context)!.enterAValidEmail;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ATextField(
                              label: AppLocalizations.of(context)!.password,
                              hint: AppLocalizations.of(context)!.enterYourPassword,
                              controller: password,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.passwordIsRequired;
                                }
                                if (value.length < 8) {
                                  return AppLocalizations.of(context)!.passwordMustBeAtLeast8Characters;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ATextField(
                              label: AppLocalizations.of(context)!.confirmPassword,
                              hint: AppLocalizations.of(context)!.confirmYourPasswords,
                              controller: confirmPassword,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.pleaseConfirmYourPassword;
                                } else if (value != password.text) {
                                  return AppLocalizations.of(context)!.passwordsDoNotMatch;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              AppLocalizations.of(context)!.city,
                              style: const TextStyle(
                                color: Color(0xFF7A8469),
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
                                  style: const TextStyle(
                                    color: Color(0xB2000000),
                                    fontSize: 18,
                                  ),
                                ),

                                items: [AppLocalizations.of(context)!.alexandria, AppLocalizations.of(context)!.cairo, AppLocalizations.of(context)!.giza]
                                    .map(
                                      (city) => DropdownMenuItem(
                                        value: city,
                                        child: Text(city),
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
                                    return AppLocalizations.of(context)!.pleaseSelectACity;
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const MainScreen();
                                      },
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
  }
}
