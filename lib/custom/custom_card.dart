import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/const.dart';

class CustomCard extends StatelessWidget {
  Color? bgColor;
  Color? CardBorderbgColor;
  Widget? child;
  final double? cardRadius;
  final GestureTapCallback? onCardPress;
  final bool isGiveWith;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? shadowColor;
  final double? Elevation;

  CustomCard({
    this.bgColor,
    this.CardBorderbgColor,
    this.child,
    this.cardRadius,
    this.onCardPress,
    this.isGiveWith = true,
    this.margin,
    this.padding,
    this.shadowColor,
    this.Elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isGiveWith ? double.infinity : null,
      child: Card(
        elevation: Elevation ?? 5,
        margin: margin ?? EdgeInsets.all(SCREEN_DEFAULT_PADDING_2W),
        shadowColor: shadowColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: CardBorderbgColor ?? bgColor ?? Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(cardRadius ?? 10),
          ),
        ),
        color: bgColor ?? AppColors.CustomCardBgColor,
        child: InkWell(
          onTap: onCardPress,
          child: Padding(
            padding: padding ?? EdgeInsets.all(8.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
