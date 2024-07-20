import 'dart:ui';

import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final double fontSize;
  final Function onCallPressed;
  final TextAlign align;

  CustomButton(
      {this.backgroundColor = Colors.black,
      this.textColor = Colors.white,
      this.text = "",
      this.fontSize = 15.0,
      required this.onCallPressed,
      this.align = TextAlign.center});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQueryData.fromWindow(window).size.width,
      child:
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
        ),
        onPressed: () => widget.onCallPressed(context),
        child: Text(
          widget.text,
          textAlign: widget.align,
          style: TextStyle(
            fontFamily: 'QuicksandBold',
            color: widget.textColor,
            fontSize: widget.fontSize,
          ),
        ),
      ),
    );
  }
}
