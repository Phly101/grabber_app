import "package:flutter/material.dart";

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;

  const ButtonWidget({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.3) ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.5),
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 12.0,
      ),
      child:  Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
