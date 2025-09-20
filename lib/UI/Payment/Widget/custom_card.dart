import "package:flutter/material.dart";
import "../../../l10n/app_localizations.dart";
class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
          width: 200,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                      AppLocalizations.of(context)!.expiry,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,)
                  ),
                ),
                Container(
                  width: 185,
                  height: 55,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: theme.colorScheme.onPrimary.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLength: 5,
                      cursorColor: Theme.of(
                        context,
                      ).colorScheme.primary,
                      decoration: InputDecoration(
                        counterText: "",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 200,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                      AppLocalizations.of(context)!.cvc,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,)
                  ),
                ),
                Container(
                  width: 185,
                  height: 55,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: theme.colorScheme.onPrimary.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            obscuringCharacter: "*",
                            obscureText: true,
                            cursorColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            decoration: InputDecoration(

                              counterText: "",
                              hint: Text(
                                "***",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              border: InputBorder.none,

                            ),
                          ),
                        ),
                        Image.asset("Assets/Icons/card-shield.png",color: theme.colorScheme.onPrimary,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
