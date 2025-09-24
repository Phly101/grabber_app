

import "package:flutter/material.dart";

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          width: 400,
          height: 60,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
              border: BoxBorder.all(color: theme.colorScheme.onPrimary.withValues(alpha: 0.7),
              ),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: Theme.of(context).colorScheme.primary,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                      ),

                    ),
                  ),
                ),
              ),

              Image.asset("Assets/Icons/masterCard.png"),
              Image.asset("Assets/Icons/visa.png"),
              const SizedBox(width: 10,),


            ],
          )

      ),
    );
  }
}
