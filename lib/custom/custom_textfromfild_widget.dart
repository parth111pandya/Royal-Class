// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../utils/const.dart';
import 'semi_bold_text_widget.dart';

class CustomTextFromField extends StatefulWidget {
  final controller;
  ValueChanged<String>? onChanged;
  BorderRadius? borderRadius;
  String? hintText;
  Widget? prefixIcon;
  bool isPassword;
  FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? margin;
  FocusNode? focusNode;
  final Color? bgColor;
  final double? height;
  final String? IconType;
  TextStyle? style;
  int? maxLines;
  String? labelText;

  CustomTextFromField({
    Key? key,
    required this.controller,
    this.isPassword = false,
    this.onChanged,
    this.borderRadius,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.margin,
    this.focusNode,
    this.bgColor,
    this.height,
    this.IconType,
    this.maxLines,
    this.style,
    this.labelText,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomTextFromField();
  }
}

class _CustomTextFromField extends State<CustomTextFromField> {
  void clearText() {
    setState(() {
      widget.controller!.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.bgColor ?? Colors.white,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: TextFormField(
        style: widget.style,
        obscureText: widget.isPassword,
        onChanged: widget.onChanged,
        controller: widget.controller,
        validator: widget.validator,
        maxLines: widget.maxLines ?? 1,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 15,
          ),
          hintText: widget.hintText,
          label: widget.hintText != null
              ? SemiBoldTextWidget(
                  title: widget.hintText,
                  fontsize: regularFontSize,
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.IconType.toString().toLowerCase() == 'pass'
              ? widget.controller.text.length > 0
                  ? IconButton(
                      icon: Icon(
                        widget.isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      iconSize: 15,
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          widget.isPassword = !widget.isPassword;
                        });
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    )
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    )
              : widget.controller.text.length > 0
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      iconSize: 15,
                      color: Colors.black,
                      onPressed: clearText,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    )
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    ),
          border: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        cursorColor: Colors.black,
        cursorWidth: 1,
      ),
    );
  }
}
