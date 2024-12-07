import 'package:flutter/material.dart';
import 'package:overcome_lust/custom_theme/color_palette.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.padding,
    this.width,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalette.accent, width: 2),
        borderRadius: BorderRadius.circular(6),
        color: isHovering ? ColorPalette.accent : null,
      ),
      child: Center(
        child: MouseRegion(
          onEnter: (event) {
            setState(() {
              isHovering = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHovering = false;
            });
          },
          child: TextButton(
            style: TextButton.styleFrom(
              overlayColor: Colors.transparent,
            ),
            onPressed: widget.onPressed,
            child: Padding(
              padding: widget.padding ??
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                widget.text,
                style: TextStyle(
                    fontSize: 16,
                    color: isHovering ? Colors.white : widget.color,
                    fontWeight: FontWeight.bold), // Button text style
              ),
            ),
          ),
        ),
      ),
    );
  }
}
