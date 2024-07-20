import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final Color? btnColor;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;

  CustomIconButton({
    required this.icon,
    required this.onPressed,
    this.btnColor,
    this.iconColor,
    this.iconSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: btnColor ?? AppColors.PrimaryColor,
        ),
        padding: padding ?? EdgeInsets.all(5),
        child: Icon(icon, color: iconColor ?? Colors.black, size: iconSize),
      ),
    );
  }
}
