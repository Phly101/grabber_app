import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:grabber_app/common/gradient_widget_container.dart";

import "../../Blocs/Theming/app_theme_bloc.dart";
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
                        ? Image.asset("Assets/Images/Grabber.png")
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
                              label: "Full Name",
                              hint: "enter your full name",
                              controller: fullName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Full Name is required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ATextField(
                              label: "Mobile Number",
                              hint: "enter your mobile number",
                              controller: mobileNumber,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Mobile Number is required";
                                } else if (!RegExp(
                                  r"^01[0-9]{9}$",
                                ).hasMatch(value)) {
                                  return "Enter a valid number";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ATextField(
                              label: "E-mail address",
                              hint: "enter your email address",
                              controller: email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required";
                                } else if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                                ).hasMatch(value)) {
                                  return "Enter a valid email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ATextField(
                              label: "Password",
                              hint: "enter your password",
                              controller: password,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                }
                                if (value.length < 8) {
                                  return "Password must be at least 8 characters";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ATextField(
                              label: "confirm password",
                              hint: "confirm your passwords",
                              controller: confirmPassword,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please confirm your password";
                                } else if (value != password.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                             Text(
                              "City",
                              style: themeBloc.state.appTheme == "L"
                                  ? Theme.of(
                                context,
                              ).textTheme.titleLarge?.copyWith(
                                color: const Color(0xFF5A5555),
                                fontWeight: FontWeight.bold,
                              )
                                  : Theme.of(
                                context,
                              ).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
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
                                hint: const Text(
                                  "Select City",
                                  style: TextStyle(
                                    color: Color(0xB2000000),
                                    fontSize: 18,
                                  ),
                                ),

                                items: ["Alexandria", "Cairo", "Giza"]
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
                                    return "Please select a city";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            AButton(
                              text: "Sign up",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.mainApp,
                                  );
                                }
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.login,
                                    );
                                  },
                                  child: const Text(
                                    "Log In!",
                                    style: TextStyle(
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
  }
}
