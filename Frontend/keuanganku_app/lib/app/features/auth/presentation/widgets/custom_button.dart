import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String? text;
  final void Function()? onPressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final double? elevation;
  final double? padding;
  final double? margin;
  final bool? isCenter;
  final bool? isFullWidth;
  final bool? isOutlined;
  const CustomButton({
    super.key,
    this.width,
    this.height,
    this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.margin,
    this.isCenter,
    this.isFullWidth,
    this.isOutlined,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width ?? double.infinity, height ?? 50),
          backgroundColor: color,
          elevation: elevation ?? 0,
          padding: EdgeInsets.all(padding ?? 0),
          textStyle: TextStyle(
            color: textColor ?? Colors.white,
            fontFamily: 'Montserrat',
            fontSize: fontSize ?? 16,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
        ),
        child: Text(text ?? ''));
  }
}
