import "package:flutter/material.dart";

class AButton extends StatelessWidget{
  final String text;
  final VoidCallback onPressed;

  const AButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF004182),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed ,child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
      ),
    );
  }
}