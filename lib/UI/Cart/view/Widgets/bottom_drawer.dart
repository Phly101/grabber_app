import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:grabber_app/UI/Cart/view/Widgets/button_widget.dart";

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
                        labelText: "Enter the email of whom you want to gift",
                        hintText: "Enter email address",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
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
                                  title: const Text("Confirm Gift"),
                                  content: Text(
                                    "Are you sure you want to send a gift to ${controller.text}?",
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context); // close dialog
                                        Fluttertoast.showToast(
                                          gravity: ToastGravity.BOTTOM,
                                          msg:
                                              "Sending gift to ${controller.text}",
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
                                      child: const Text("Confirm"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                      ),
                                      child: const Text("Cancel"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: const ButtonWidget(text: "Send Gift!", color: Colors.green,),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const ButtonWidget(text: "Cancel", color: Colors.redAccent),
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
