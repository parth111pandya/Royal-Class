import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/const.dart';

class MediumTextWidget extends StatefulWidget {
  String? title;
  double? fontsize;
  Color? fontcolor;
  TextAlign? align;

  MediumTextWidget({this.title, this.fontsize, this.fontcolor, this.align});

  @override
  State<MediumTextWidget> createState() => _MediumTextWidgetState();
}

class _MediumTextWidgetState extends State<MediumTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title.toString(),
      style: TextStyle(
        fontFamily: FONT_STYLE_QUICK_MEDIUM,
        fontSize: widget.fontsize ?? 14,
        color: widget.fontcolor ?? AppColors.PrimaryColor,
      ),
      textAlign: widget.align ?? TextAlign.start,
    );
  }
}
