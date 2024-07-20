import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'bold_text_widget.dart';
import 'medium_text_widget.dart';

// ignore: must_be_immutable
class CustomContainer extends StatefulWidget implements PreferredSizeWidget {
  String? title;
  final IconData? rightIcon;
  double? fontsize;
  final IconData? leftIcon;
  Color? fontcolor;

  CustomContainer({
    Key? key,
    this.title,
    this.fontsize,
     this.leftIcon,
    this.rightIcon,
    this.fontcolor,
  }) : super(key: key);

  @override
  State<CustomContainer> createState() => _CustomContainerState();

  @override
  Size get preferredSize => Size.fromHeight(8);
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 28.w,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFFC9DDEC),
        // border: Border.all(),
        borderRadius: BorderRadius.all(
            Radius.circular(
                15.0) //                 <--- border radius here
        ),
      ),


      child: Row(
        children: [
          Icon(widget.rightIcon, size: 19,
            color: Colors.black,),
          SizedBox(
            width: 20,

          ),
          Expanded(
            child: MediumTextWidget(
              title: widget.title,
              fontsize: widget.fontsize ?? 17,
                fontcolor: widget.fontcolor ?? Colors.black,
            ),
          ),
          Icon(widget.leftIcon,
              size: 18,
              color: Colors.black12)
        ],
      ),
    );
  }
}
