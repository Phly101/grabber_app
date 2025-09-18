import "package:flutter/material.dart";

class CustomRow extends StatelessWidget {
  final String option;

  final String url;


  const CustomRow({
    super.key,
    required this.option,

    required this.url,

  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(url,color: theme.colorScheme.onPrimary,),
            ),
            Expanded(
              child: Text(
                option,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            RadioMenuButton(
              value: option,
              groupValue: option,
              onChanged: (val){},
              child: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
