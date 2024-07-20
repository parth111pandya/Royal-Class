import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/const.dart';

class BoldTextWidget extends StatefulWidget {
  String? title;
  double? fontsize;
  Color? fontcolor;
  TextAlign? align;

  BoldTextWidget({this.title, this.fontsize, this.fontcolor, this.align});

  @override
  State<BoldTextWidget> createState() => _BoldTextWidgetState();
}

class _BoldTextWidgetState extends State<BoldTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title.toString(),
      style: TextStyle(
        fontFamily: FONT_STYLE_QUICK_BOLD,
        fontSize: widget.fontsize ?? 14,
        color: widget.fontcolor ?? AppColors.PrimaryColor,
      ),
      textAlign: widget.align ?? TextAlign.start,
    );
  }
}
