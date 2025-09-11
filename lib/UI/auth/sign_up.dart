import 'package:flutter/material.dart';
import '../../Theme/light_theme.dart';
import '../main_app/main_screen.dart';
import 'components/button.dart';
import 'components/text_field.dart';

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
                            SizedBox(height: 50),
                            ATextField(
                              label: "Full Name",
                              hint: "enter your full name",
                              controller: fullName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Full Name is required";
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            ATextField(
                              label: "Mobile Number",
                              hint: "enter your mobile number",
                              controller: mobileNumber,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Mobile Number is required";
                                } else if (!RegExp(
                                  r'^01[0-9]{9}$',
                                ).hasMatch(value)) {
                                  return "Enter a valid number";
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            ATextField(
                              label: "E-mail address",
                              hint: "enter your email address",
                              controller: email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required";
                                } else if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                                ).hasMatch(value)) {
                                  return "Enter a valid email";
                                }
                              },
                            ),
                            SizedBox(height: 20),
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
                              },
                            ),
                            SizedBox(height: 20),
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
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              "City",
                              style: TextStyle(
                                color: Color(0xFF7A8469),
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 10),
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
                                },
                              ),
                            ),
                            SizedBox(height: 25),
                            AButton(
                              text: "Sign up",
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
