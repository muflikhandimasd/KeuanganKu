import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final double? width;
  final double? height;
  final String? hintText;

  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? enabled;
  final int? maxLines;
  final int? maxLength;
  final void Function(String)? onChanged;

  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  final String? errorText;
  const CustomTextField({
    super.key,
    this.width,
    this.height,
    this.hintText,
    this.keyboardType,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled,
    this.maxLines,
    this.maxLength,
    this.onChanged,
    this.textInputAction,
    this.errorText,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 100,
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        enabled: enabled ?? true,
        maxLines: maxLines ?? 1,
        maxLength: maxLength,
        onChanged: onChanged,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          errorText: errorText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
