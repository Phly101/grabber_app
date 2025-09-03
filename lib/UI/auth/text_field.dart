import 'package:flutter/material.dart';

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