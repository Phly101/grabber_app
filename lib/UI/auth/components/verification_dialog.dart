
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:grabber_app/Services/Verification/Bloc/verification_bloc.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:grabber_app/l10n/app_localizations.dart";

class VerificationDialog extends StatelessWidget {
  const VerificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<VerificationBloc>().add(SendVerificationEmail());
    return AlertDialog(
      title: const Text("Email Verification"),
      content: BlocConsumer<VerificationBloc, VerificationState>(
        listener: (context, state) {
          if (state is VerficationEmailSent) {
            Fluttertoast.showToast(
              msg: AppLocalizations.of(context)!.emailVerificationTitle,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else if (state is VerficationChecked) {
            if (state.isVerified) {
              Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.emailVerified,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRoutes.mainApp);
            } else {
              Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.emailNotVerified,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          } else if (state is VerficationError) {
            Fluttertoast.showToast(
              msg: "Error: ${state.message}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
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
                style: const TextStyle(fontSize: 16),
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