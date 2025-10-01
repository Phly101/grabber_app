import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:grabber_app/l10n/app_localizations.dart";

import "../../../Services/Users/Bloc/user_bloc.dart";

class EditDialog extends StatelessWidget {
  final String field;
  final String currentValue;

  const EditDialog({
    super.key,
    required this.field,
    required this.currentValue,
  });

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    final TextEditingController controller = TextEditingController(
      text: currentValue,
    );
    final theme = Theme.of(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserUpdateSuccess) {
          showToast(AppLocalizations.of(context)!.dataUpdatedSuccessfully);
          Navigator.pop(context);
        } else if (state is UserUpdateError) {
          showToast(AppLocalizations.of(context)!.failedToUpdateData);
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: theme.colorScheme.surface,
        title: Text(
          field == "name"
              ? AppLocalizations.of(context)!.updateName
              : AppLocalizations.of(context)!.updatePhoneNumber,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: field == "name"
                  ? AppLocalizations.of(context)!.enterYourFullName
                  : AppLocalizations.of(context)!.enterYourMobileNumber,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.colorScheme.primary),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            validator: (value) {
              if (field == "name") {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(
                    context,
                  )!.fullNameIsRequired;
                }
                return null;
              } else {
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
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (field == "name") {
                  context.read<UserBloc>().add(
                    UpdateUserName(newName: controller.text),
                  );
                } else {
                  context.read<UserBloc>().add(
                    UpdatePhoneNum(newNum: controller.text),
                  );
                }
              }
            },
            child: Text(
              AppLocalizations.of(context)!.save,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
