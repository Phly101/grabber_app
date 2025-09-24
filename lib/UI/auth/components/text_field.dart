import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Theme/theme.dart";

class ATextField extends StatefulWidget {
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

class _ATextFieldState extends State<ATextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<AppThemeBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: themeBloc.state.appTheme == "L"
              ? Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF5A5555),
                  fontWeight: FontWeight.bold,
                )
              : Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText && !isVisible,
          validator: widget.validator,
          style: const TextStyle(color: AppColors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle:  TextStyle(color: const Color(0xB2000000).withValues(alpha: 0.5), fontSize: 18),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(
                      isVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xB2000000),
                    ),
                  )
                : null,
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
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
