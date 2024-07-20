import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomDividerLMS extends StatelessWidget {
  Color? dividerColor;

  CustomDividerLMS({this.dividerColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: dividerColor ?? AppColors.DividerColor,
    );
  }
}
