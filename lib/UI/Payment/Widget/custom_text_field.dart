

import "package:flutter/material.dart";
import "package:grabber_app/Theme/light_theme.dart";

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          width: 400,
          height: 60,
          decoration: BoxDecoration(
              border: BoxBorder.all(color: LightThemeData.blackColor.withValues(alpha: 0.7),
              ),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: Theme.of(context).colorScheme.onPrimary,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 2),
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
