import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/const.dart';

class RegularTextWidget extends StatefulWidget {
  String? title;
  double? fontsize;
  Color? fontcolor;
  TextAlign? align;

  RegularTextWidget({this.title, this.fontsize, this.fontcolor, this.align});

  @override
  State<RegularTextWidget> createState() => _RegularTextWidgetState();
}

class _RegularTextWidgetState extends State<RegularTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title.toString(),
      style: TextStyle(
        fontFamily: FONT_STYLE_QUICK_REGULAR,
        fontSize: widget.fontsize ?? 14,
        color: widget.fontcolor ?? AppColors.PrimaryColor,
      ),
      textAlign: widget.align ?? TextAlign.start,
    );
  }
}
