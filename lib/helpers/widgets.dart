import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    // TextStyle finalStyle = style ?? TextStyle();
    // finalStyle = finalStyle.copyWith(
    //   color: color ?? finalStyle.color,
    //   fontSize: fontSize ?? finalStyle.fontSize,
    //   fontWeight: fontWeight ?? finalStyle.fontWeight,
    //   fontStyle: fontStyle ?? finalStyle.fontStyle,
    //   letterSpacing: letterSpacing ?? finalStyle.letterSpacing,
    //   wordSpacing: wordSpacing ?? finalStyle.wordSpacing,
    // );

    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize ?? 18,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
      ),
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
