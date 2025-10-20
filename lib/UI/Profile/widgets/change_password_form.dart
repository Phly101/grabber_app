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
                            label: AppLocalizations.of(context)!.email,
                            hint: AppLocalizations.of(
                              context,
                            )!.enterYourEmailAddress,
                            icon: FontAwesomeIcons.envelope,
                            isVisible: false,
                            toggleVisibility: () {},
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(
                                context,
                              )!.emailIsRequired;
                            }
                            const pattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
                            final regex = RegExp(pattern);
                            if (!regex.hasMatch(value)) {
                              return AppLocalizations.of(
                                context,
                              )!.enterAValidEmail;
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
                            label: AppLocalizations.of(
                              context,
                            )!.currentPassword,
                            hint: AppLocalizations.of(
                              context,
                            )!.enterCurrentPassword,
                            icon: FontAwesomeIcons.lock,
                            isPassword: true,
                            isVisible: currentVisible,
                            toggleVisibility: () => setState(
                              () => currentVisible = !currentVisible,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(
                                context,
                              )!.currentPasswordEmpty;
                            }
                            if (value.length < 6) {
                              return AppLocalizations.of(
                                context,
                              )!.passwordMustBeAtLeast6Characters;
                            }
                            return null;
                          },
                          onChanged: (value) {
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
                                msg: AppLocalizations.of(
                                  context,
                                )!.sendingRequest,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else if (state is AuthForgotPassword) {
                              Fluttertoast.showToast(
                                msg: AppLocalizations.of(
                                  context,
                                )!.passwordResetEmailSent,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else if (state is AuthUpdatePassword) {
                              Fluttertoast.showToast(
                                msg: state.message,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );

                              Navigator.pop(context);
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
                              label: AppLocalizations.of(context)!.newPassword,
                              hint: AppLocalizations.of(
                                context,
                              )!.enterNewPassword,
                              icon: FontAwesomeIcons.key,
                              isPassword: true,
                              isVisible: newVisible,
                              toggleVisibility: () =>
                                  setState(() => newVisible = !newVisible),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(
                                  context,
                                )!.newPasswordEmpty;
                              }
                              if (value.length < 6) {
                                return AppLocalizations.of(
                                  context,
                                )!.passwordMustBeAtLeast6Characters;
                              }
                              if (value == currentPasswordController.text) {
                                return AppLocalizations.of(
                                  context,
                                )!.newPasswordDifferent;
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
                              label: AppLocalizations.of(
                                context,
                              )!.confirmNewPassword,
                              hint: AppLocalizations.of(
                                context,
                              )!.reEnterNewPassword,
                              icon: FontAwesomeIcons.lock,
                              isPassword: true,
                              isVisible: confirmVisible,
                              toggleVisibility: () => setState(
                                () => confirmVisible = !confirmVisible,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(
                                  context,
                                )!.confirmPasswordEmpty;
                              }
                              if (value != newPasswordController.text) {
                                return AppLocalizations.of(
                                  context,
                                )!.passwordsDoNotMatch;
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
                                child: ButtonWidget(
                                  text: Text(
                                    AppLocalizations.of(context)!.confirm,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                  color: Colors.green,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: ButtonWidget(
                                  text: Text(
                                    AppLocalizations.of(context)!.cancel,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.white),
                                  ),
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
