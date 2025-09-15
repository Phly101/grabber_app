import 'package:flutter/material.dart';
import 'package:grabber_app/UI/auth/sign_up.dart';
import '../../Theme/light_theme.dart' show LightThemeData;
import "../../l10n/app_localizations.dart";
import '../main_app/main_screen.dart';
import 'components/button.dart';
import 'components/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

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
                        // autovalidateMode: AutovalidateMode.always,
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50),
                            Text(
                              AppLocalizations.of(context)!.welcomeBackToGrabber,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: Color(0xFF5A5555),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              AppLocalizations.of(context)!.pleaseSignInWithYourMail,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Color(0xAB5A5555)),
                            ),
                            SizedBox(height: 40),
                            ATextField(
                              label: AppLocalizations.of(context)!.userName,
                              hint: AppLocalizations.of(context)!.enterYourName,
                              controller: username,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.userNameIsRequired;
                                }
                              },
                            ),
                            SizedBox(height: 20),
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
                              },
                            ),
                            SizedBox(height: 3),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  AppLocalizations.of(context)!.forgotPassword,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            AButton(
                              text: AppLocalizations.of(context)!.login,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MainScreen();
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.dontHaveAnAccount,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return SignUp();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.createAccount,
                                    style: TextStyle(
                                      color: Colors.white,
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
                  // alignment: Alignment.topLeft,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
