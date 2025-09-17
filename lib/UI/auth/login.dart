import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:grabber_app/common/gradient_widget_container.dart";
import "../../Blocs/Theming/app_theme_bloc.dart";
import "../main_app/main_screen.dart";
import "components/button.dart";
import "components/text_field.dart";

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
                            Text(
                              "Welcome Back To Grabber",
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
                            const SizedBox(height: 5),
                            Text(
                              "Please sign in with your mail",
                              style: themeBloc.state.appTheme == "L"
                                  ? Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                color: const Color(0xFF5A5555),
                                fontWeight: FontWeight.bold,
                              )
                                  : Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 40),
                            ATextField(
                              label: "User Name",
                              hint: "enter your name",
                              controller: username,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "User Name is required";
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
                            const SizedBox(height: 3),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot password",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            AButton(
                              text: "Login",
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
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don’t have an account?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.signUp,
                                    );
                                  },
                                  child: const Text(
                                    "Create Account",
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
