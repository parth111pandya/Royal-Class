// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'bold_text_widget.dart';

class CustomElevatedButton extends StatefulWidget {
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final double fontSize;
  final GestureTapCallback? onCallPressed;
  final TextAlign align;
  final double? BtnWidthsize;
  final EdgeInsetsGeometry? btnPadding;

  CustomElevatedButton({
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.text = "",
    this.fontSize = 15.0,
    required this.onCallPressed,
    this.align = TextAlign.center,
    this.BtnWidthsize,
    this.btnPadding,
  });

  @override
  _CustomElevatedButtonState createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.BtnWidthsize ?? 25,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          padding: widget.btnPadding ?? EdgeInsets.fromLTRB(0, 14, 0, 14),
        ),
        onPressed: widget.onCallPressed,
        child: BoldTextWidget(
          title: widget.text,
          align: widget.align,
          fontcolor: widget.textColor,
          fontsize: widget.fontSize,
        ),
      ),
    );
  }
}
