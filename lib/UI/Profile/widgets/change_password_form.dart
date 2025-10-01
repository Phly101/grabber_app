import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:grabber_app/Services/Authentication/bloc/auth_bloc.dart";
import "package:grabber_app/UI/Cart/view/Widgets/button_widget.dart";
import "package:grabber_app/l10n/app_localizations.dart";

class ChangePasswordForm {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  const ChangePasswordForm({
    required this.formKey,
    required this.emailController,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  InputDecoration buildInputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    required bool isVisible,
    required VoidCallback toggleVisibility,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade500),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FaIcon(icon, color: Colors.grey.shade700, size: 22),
      ),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                isVisible ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                size: 20,
                color: Colors.grey.shade600,
              ),
              onPressed: toggleVisibility,
            )
          : null,
    );
  }

  void showChangePasswordForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        bool currentVisible = false;
        bool newVisible = false;
        bool confirmVisible = false;
        bool showNewFields = false;

        // Inside StatefulBuilder
        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      controller: scrollController,
                      children: [
                        // Email
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: buildInputDecoration(
                            label: "Email",
                            hint: "Enter email address",
                            icon: FontAwesomeIcons.envelope,
                            isVisible: false,
                            toggleVisibility: () {},
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email cannot be empty";
                            }
                            const pattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
                            final regex = RegExp(pattern);
                            if (!regex.hasMatch(value)) {
                              return "Enter a valid email address";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Current Password
                        TextFormField(
                          controller: currentPasswordController,
                          obscureText: !currentVisible,
                          decoration: buildInputDecoration(
                            label: "Current Password",
                            hint: "Enter current password",
                            icon: FontAwesomeIcons.lock,
                            isPassword: true,
                            isVisible: currentVisible,
                            toggleVisibility: () => setState(
                              () => currentVisible = !currentVisible,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Current password cannot be empty";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }

                            return null;
                          },
                          onChanged: (value) {
                            // show new fields only if valid length
                            if (value.length >= 6 && !showNewFields) {
                              setState(() => showNewFields = true);
                            } else if (value.isEmpty && showNewFields) {
                              setState(() => showNewFields = false);
                            }
                          },
                        ),

                        const SizedBox(height: 16),

                        BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthUpdatePasswordLoading) {
                              Fluttertoast.showToast(
                                msg: "Sending your request ...",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else if (state is AuthForgotPassword) {
                              Fluttertoast.showToast(
                                msg: "Password reset email sent successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                            else if (state is AuthUpdatePassword) {
                              Fluttertoast.showToast(
                                msg: state.message,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );

                              Navigator.pop(context);
                            }
                            else if (state is AuthError) {
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
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                  ForgotPasswordRequested(
                                    email: emailController.text,
                                  ),
                                );
                                Navigator.of(context);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.forgotPassword,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),

                        // Show only after current password is filled
                        if (showNewFields) ...[
                          Divider(
                            height: 1,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(height: 16),
                          // New Password
                          TextFormField(
                            controller: newPasswordController,
                            obscureText: !newVisible,
                            decoration: buildInputDecoration(
                              label: "New Password",
                              hint: "Enter new password",
                              icon: FontAwesomeIcons.key,
                              isPassword: true,
                              isVisible: newVisible,
                              toggleVisibility: () =>
                                  setState(() => newVisible = !newVisible),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "New password cannot be empty";
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              if (value == currentPasswordController.text) {
                                return "New password must be different from current password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Confirm Password
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: !confirmVisible,
                            decoration: buildInputDecoration(
                              label: "Confirm Password",
                              hint: "Re-enter new password",
                              icon: FontAwesomeIcons.lock,
                              isPassword: true,
                              isVisible: confirmVisible,
                              toggleVisibility: () => setState(
                                () => confirmVisible = !confirmVisible,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Confirm password cannot be empty";
                              }
                              if (value != newPasswordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      UpdatePasswordRequested(
                                        currentEmail: emailController.text,
                                        currentPassword:
                                            currentPasswordController.text,
                                        newPassword: newPasswordController.text,
                                      ),
                                    );


                                  }
                                },
                                child: const ButtonWidget(
                                  text: "Confirm",
                                  color: Colors.green,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const ButtonWidget(
                                  text: "Cancel",
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
