import 'package:flutter/material.dart';

import '../../Theme/light_theme.dart';

class Components extends StatelessWidget{
  final Widget child;
  final double height;
  const Components({super.key, required this.child, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            LightThemeData.primaryLightColor,
            LightThemeData.secondaryLightColor,
            LightThemeData.secondaryDarkColor,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text("Grabber", style: TextStyle(color: LightThemeData.darkPrimaryColor, fontWeight: FontWeight.bold, fontSize: 50),),
              ),
              SizedBox(height: height),
              Expanded(
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ATextField extends StatefulWidget{
  final String label;
  final String hint;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const ATextField({
    super.key,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.controller,
    this.validator,
  });

  @override
  State<ATextField> createState() => _ATextFieldState();
}

class _ATextFieldState extends State<ATextField>{
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(color: Color(0xFF7A8469), fontWeight: FontWeight.w600, fontSize: 20,),),
        const SizedBox(height: 20),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText && !isVisible,
          validator: widget.validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: TextStyle(color: Color(0xB2000000), fontSize: 18),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: widget.obscureText? IconButton(onPressed: (){
              setState(() {
                isVisible = !isVisible;
              });
            }, icon: Icon(isVisible? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Color(0xB2000000),),) : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

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
          foregroundColor: Color(0xFF004182),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed ,child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
      ),
    );
  }
}


