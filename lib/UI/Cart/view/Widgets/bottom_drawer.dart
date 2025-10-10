import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:grabber_app/UI/Cart/view/Widgets/button_widget.dart";
import "package:grabber_app/l10n/app_localizations.dart";

class BottomDrawer {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;

  const BottomDrawer({required this.formKey, required this.controller});

  void openBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: ListView(
                  controller: scrollController,
                  children: [
                    TextFormField(
                      controller: controller,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.enterGiftEmail,
                        hintText: AppLocalizations.of(context)!.emailAddress,
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.emailIsRequired;
                        }
                        const pattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
                        final regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return AppLocalizations.of(context)!.enterAValidEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text(AppLocalizations.of(context)!.confirmGift),
                                  content: Text(
                                    "${AppLocalizations.of(context)!.areYouSureGift} ${controller.text}?",
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context); // close dialog
                                        Fluttertoast.showToast(
                                          gravity: ToastGravity.BOTTOM,
                                          msg: "${AppLocalizations.of(context)!.sendingGiftTo} ${controller.text}",
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        controller.clear();
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.Confirm,
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.Cancel,
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: ButtonWidget(
                            text: Text(
                              AppLocalizations.of(context)!.Confirm,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
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
                              AppLocalizations.of(context)!.Cancel,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                            ),
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
