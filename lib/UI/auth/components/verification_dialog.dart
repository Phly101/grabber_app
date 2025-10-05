
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabber_app/Services/Verification/Bloc/verification_bloc.dart';
import 'package:grabber_app/Utils/routes.dart';
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/l10n/app_localizations.dart";

class VerificationDialog extends StatelessWidget {
  const VerificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Email Verification"),
      content: BlocConsumer<VerificationBloc, VerificationState>(
        listener: (context, state) {
          if (state is VerficationEmailSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)!.emailVerificationTitle)),
            );
          } else if (state is VerficationChecked) {
            if (state.isVerified) {
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(AppLocalizations.of(context)!.emailVerified)),
              );
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRoutes.mainApp);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context)!.emailNotVerified)),
              );
            }
          } else if (state is VerficationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.message}")),
            );
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(
                AppLocalizations.of(context)!.verificationInstruction,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<VerificationBloc>().add(CheckEmailVerification());
                },
                child: state is VerficationLoading
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                )
                    :  Text(
                  AppLocalizations.of(context)!.checkNowButton,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              // TextButton(
              //   onPressed: () {
              //     context.read<VerificationBloc>().add(SendVerificationEmail());
              //   },
              //   style: TextButton.styleFrom(
              //     foregroundColor: Theme.of(context).colorScheme.primary,
              //   ),
              //   child: Text(AppLocalizations.of(context)!.resendEmailButton),
              // ),
              if (state is! VerficationEmailCooldown) ...[
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    context.read<VerificationBloc>().add(SendVerificationEmail());
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(AppLocalizations.of(context)!.resendEmailButton),
                ),
              ] else ...[
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.verificationCooldown,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],

            ],
          );
        },
      ),
    );
  }
}