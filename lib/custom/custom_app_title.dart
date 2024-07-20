import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'bold_text_widget.dart';

// ignore: must_be_immutable
class CustomAppBarTitle extends StatefulWidget implements PreferredSizeWidget {
  String? title;
  double? fontsize;
  Color? fontcolor;
  Color? appBarBgcolor;
  TextAlign? align;
  List<Widget>? actionsWidget;

  CustomAppBarTitle(
      {Key? key,
      this.title,
      this.fontsize,
      this.fontcolor,
      this.align,
      this.appBarBgcolor,
      this.actionsWidget})
      : super(key: key);

  @override
  State<CustomAppBarTitle> createState() => _CustomAppBarTitleState();

  @override
  Size get preferredSize => Size.fromHeight(45);
}

class _CustomAppBarTitleState extends State<CustomAppBarTitle> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.appBarBgcolor ?? AppColors.PrimaryColor,
      title: BoldTextWidget(
          title: widget.title ?? "",
          fontsize: widget.fontsize ?? 18,
          fontcolor: widget.fontcolor ?? Colors.white),
      actions: widget.actionsWidget,
    );
  }
}
