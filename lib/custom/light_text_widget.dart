import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/const.dart';

class LightTextWidget extends StatefulWidget {
  String? title;
  double? fontsize;
  Color? fontcolor;
  TextAlign? align;

  LightTextWidget({this.title, this.fontsize, this.fontcolor, this.align});

  @override
  State<LightTextWidget> createState() => _LightTextWidgetState();
}

class _LightTextWidgetState extends State<LightTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title.toString(),
      style: TextStyle(
        fontFamily: FONT_STYLE_QUICK_LIGHT,
        fontSize: widget.fontsize ?? 14,
        color: widget.fontcolor ?? AppColors.PrimaryColor,
      ),
      textAlign: widget.align ?? TextAlign.start,
    );
  }
}
