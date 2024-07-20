import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final textController;
  final IconData leftIcon;
  final IconData rightIcon;
  final double topMargin;
  final TextCapitalization textCapitalization;
  final String hintText;
  final String errorMessage;
  final Color color;
  final TextInputType textInputType;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final TextInputAction textInputAction;
  final int maxLength;
  final bool focus;
  bool isPassword;
  final FocusNode nextfocusNode;
  final FocusNode focusNode;
  final String? IconType;

  CustomTextField({
    this.textController,
    this.leftIcon = Icons.mobile_screen_share,
    this.topMargin = 0,
    this.hintText = "",
    this.rightIcon = Icons.clear,
    this.color = Colors.grey,
    this.errorMessage = '',
    this.textInputType = TextInputType.text,
    required this.validator,
    required this.onSaved,
    this.maxLength = 0,
    this.textInputAction = TextInputAction.done,
    required this.focus,
    required this.focusNode,
    required this.nextfocusNode,
    this.isPassword = false,
    this.textCapitalization = TextCapitalization.none,
    this.IconType,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomTextField();
  }
}

class _CustomTextField extends State<CustomTextField> {
  void clearText() {
    setState(() {
      widget.textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.fromLTRB(0, widget.topMargin, 0, 0),
      child: TextFormField(
        validator: widget.validator,
        onSaved: widget.onSaved,
        textCapitalization: widget.textCapitalization,
        controller: widget.textController,
        keyboardType: widget.textInputType,
        obscureText: widget.isPassword,
        enableSuggestions: !widget.isPassword,
        decoration: InputDecoration(
          errorText: widget.errorMessage.toString().length > 0
              ? widget.errorMessage
              : null,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
          suffixIcon: widget.IconType.toString().toLowerCase() == 'pass'
              ? widget.textController.text.length > 0
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
                  : new Container(
                      height: 0.0,
                      width: 0,
                    )
              : widget.textController.text.length > 0
                  ? IconButton(
                      icon: Icon(widget.rightIcon),
                      iconSize: 15,
                      color: Colors.black,
                      onPressed: clearText,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    )
                  : new Container(
                      height: 0.0,
                      width: 0,
                    ),
          hintText: widget.hintText,
          hintStyle:
              TextStyle(color: widget.color, fontFamily: 'QuicksandRegular'),
          filled: false,
          fillColor: Colors.transparent,
          prefixIcon: Padding(
            padding: EdgeInsets.all(0.0),
            child: Icon(
              widget.leftIcon,
              color: widget.color,
            ), // icon is 48px widget.
          ),
        ),
        textInputAction: widget.textInputAction,
        onChanged: (text) {
          setState(() {});
        },
        style: TextStyle(color: Colors.black, fontFamily: 'QuicksandMedium'),
        autofocus: false,
        cursorColor: Colors.black,
      ),
    );
  }
}
