import 'package:dog_age_plus/base/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final TextInputType? keyboardType;
  final bool obscureText;

  const CupertinoField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      placeholder: placeholder,
      placeholderStyle: const TextStyle(color: Color(0x3C3C434D), fontSize: 17),
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 17),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ), // handled by parent card
    );
  }
}
