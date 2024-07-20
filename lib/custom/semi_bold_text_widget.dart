import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/const.dart';

class SemiBoldTextWidget extends StatefulWidget {
  String? title;
  double? fontsize;
  Color? fontcolor;
  TextAlign? align;
  int? maxLines;

  SemiBoldTextWidget({
    Key? key,
    this.title,
    this.fontsize,
    this.fontcolor,
    this.align,
    this.maxLines,
  }) : super(key: key);

  @override
  State<SemiBoldTextWidget> createState() => _SemiBoldTextWidgetState();
}

class _SemiBoldTextWidgetState extends State<SemiBoldTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title.toString(),
      maxLines: widget.maxLines,
      style: TextStyle(
        fontFamily: FONT_STYLE_QUICK_SEMI_BOLD,
        fontSize: widget.fontsize ?? 14,
        color: widget.fontcolor ?? AppColors.PrimaryColor,
      ),
      textAlign: widget.align ?? TextAlign.start,
    );
  }
}
