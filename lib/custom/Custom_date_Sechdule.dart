import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'bold_text_widget.dart';

class CustomeDatewidgetIASechdule extends StatelessWidget {
  String dateText;
  String? DataText;
  double? fontSize;
  Color? textColor;
  Color? backGroundColor;
  EdgeInsetsGeometry? padding;

  CustomeDatewidgetIASechdule({
    required this.dateText,
    this.fontSize,
    this.textColor,
    this.backGroundColor,
    this.DataText,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 1, horizontal: 6),
      decoration: BoxDecoration(
        color: backGroundColor != null
            ? backGroundColor
            : AppColors.CustomeDateBgColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today,
              size: fontSize ?? 12,
              color: textColor != null
                  ? textColor
                  : AppColors.CustomeDateIconColor),
          const SizedBox(
            width: 5,
          ),
          BoldTextWidget(
            title: dateText,
            fontsize: fontSize ?? 12,
            fontcolor: textColor != null ? textColor : AppColors.PrimaryColor,
          )
        ],
      ),
    );
  }
}
