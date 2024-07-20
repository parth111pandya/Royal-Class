import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../custom/bold_text_widget.dart';
import '../custom/medium_text_widget.dart';
import '../custom/regular_text_widget.dart';
import '../utils/colors.dart';
import '../utils/const.dart';

mixin DialogMixin {
  void showAlertDialog(
    context,
    title,
    message,
    yes,
    no,
    Function callback,
  ) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        if (no != null)
          return getDialogTwoButton(context, title, message, yes, no, callback);
        else
          return getDialogOneButton(context, title, message, yes, no, callback);
      },
      barrierDismissible: false,
    );
  }

  void showGetXToast(text, message) {
    if (text != null && text.toString().length > 0) {
      Get.snackbar(
        text,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xFF191E26),
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }
  Widget convertHtmlToString(message) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          // minHeight: 1.h,
          // maxHeight: 10.h,
          ),
      child: Container(
        // height: 10.h,
        child: Html(
          data: message.toString(),
          shrinkWrap: true,
          style: {
            "body": Style(
              fontSize: FontSize(14.0),
              fontFamily: FONT_STYLE_QUICK_MEDIUM,
            ),
          },
        ),
      ),
    );
  }

  CupertinoAlertDialog getDialogTwoButton(
      context, title, message, yes, no, Function callback) {
    RenderObject.debugCheckingIntrinsics = true;
    return CupertinoAlertDialog(
      title: title != null
          ? Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontFamily: FONT_STYLE_QUICK_BOLD,
              ),
            )
          : Container(),
      content: message != null ? convertHtmlToString(message) : Container(),
      actions: [
        yes != null
            ? CupertinoDialogAction(
                child: Text(
                  yes,
                  style: TextStyle(fontFamily: FONT_STYLE_QUICK_MEDIUM),
                ),
                onPressed: () {
                  Future.delayed(
                    Duration(milliseconds: 10),
                    () => callback(true),
                  );
                  Navigator.of(context).pop();
                },
              )
            : Container(),
        no != null
            ? CupertinoDialogAction(
                child: Text(
                  no,
                  style: TextStyle(fontFamily: FONT_STYLE_QUICK_MEDIUM),
                ),
                onPressed: () {
                  Future.delayed(
                    Duration(milliseconds: 10),
                    () => callback(false),
                  );
                  Navigator.of(context).pop();
                },
              )
            : Container(),
      ],
    );
  }

  CupertinoAlertDialog getDialogOneButton(
      context, title, message, yes, no, Function callback) {
    RenderObject.debugCheckingIntrinsics = true;
    return CupertinoAlertDialog(
      title: title != null
          ? Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontFamily: FONT_STYLE_QUICK_BOLD,
              ),
            )
          : Container(),
      content: message != null
          ? Html(
              data: message.toString(),
              style: {
                "body": Style(
                  fontSize: FontSize(14.0),
                  fontFamily: FONT_STYLE_QUICK_MEDIUM,
                ),
              },
            )
          : Container(),
      actions: [
        yes != null
            ? CupertinoDialogAction(
                child: Text(
                  yes,
                  style: TextStyle(fontFamily: FONT_STYLE_QUICK_MEDIUM),
                ),
                onPressed: () {
                  Future.delayed(
                    Duration(milliseconds: 10),
                    () => callback(true),
                  );
                  Navigator.of(context).pop();
                },
              )
            : Container(),
      ],
    );
  }

  void showAlertDialogForgot(
      context, title, message, yes, no, Function callback) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        if (no != null) {
          return getDialogTwoButtonForgot(
              context, title, message, yes, no, callback);
        } else {
          return getDialogOneButtonForgot(
              context, title, message, yes, no, callback);
        }
      },
      barrierDismissible: false,
    );
  }

  CupertinoAlertDialog getDialogTwoButtonForgot(
      context, title, message, yes, no, Function callback) {
    RenderObject.debugCheckingIntrinsics = true;
    return CupertinoAlertDialog(
      title: title != null
          ? Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: FONT_STYLE_QUICK_BOLD,
                fontSize: 14,
              ),
            )
          : Container(),
      content: message != null
          ? Html(
              data: message.toString(),
              shrinkWrap: true,
              style: {
                "body": Style(
                  fontSize: FontSize(15.0),
                  fontFamily: FONT_STYLE_QUICK_MEDIUM,
                  textAlign: TextAlign.center,
                ),
              },
            )
          : Container(),
      actions: [
        yes != null
            ? CupertinoDialogAction(
                child: Text(yes),
                onPressed: () {
                  Future.delayed(
                    const Duration(milliseconds: 10),
                    () => callback(true),
                  );
                  Navigator.of(context).pop();
                })
            : Container(),
        no != null
            ? CupertinoDialogAction(
                child: Text(no),
                onPressed: () {
                  Future.delayed(
                    const Duration(milliseconds: 10),
                    () => callback(false),
                  );
                  Navigator.of(context).pop();
                })
            : Container(),
      ],
    );
  }

  CupertinoAlertDialog getDialogOneButtonForgot(
      context, title, message, yes, no, Function callback) {
    RenderObject.debugCheckingIntrinsics = true;
    return CupertinoAlertDialog(
      title: title != null
          ? Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: FONT_STYLE_QUICK_BOLD,
              ),
            )
          : Container(),
      content: message != null
          ? Html(
              data: message.toString(),
              style: {
                "body": Style(
                  fontSize: FontSize(14.0),
                  fontFamily: FONT_STYLE_QUICK_MEDIUM,
                  textAlign: TextAlign.center,
                ),
              },
              shrinkWrap: true,
            )
          : Container(),
      actions: [
        yes != null
            ? CupertinoDialogAction(
                child: Text(yes),
                onPressed: () {
                  Future.delayed(
                    const Duration(milliseconds: 10),
                    () => callback(true),
                  );
                  Navigator.of(context).pop();
                })
            : Container(),
      ],
    );
  }

  void showFlutterToast({text, ToastGravity? toastGravity}) {
    if (text != null && text.toString().length > 0)
      Fluttertoast.showToast(
          msg: text,
          toastLength: Toast.LENGTH_SHORT,
          webBgColor: "#e7505a",
          timeInSecForIosWeb: 5,
          gravity: toastGravity);
  }

  void showAlertDialogWithWidget(
      {context, title, yes, no, widget, required Function callback}) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return CupertinoAlertDialog(
              title: RegularTextWidget(
                title: title,
                align: TextAlign.center,
                fontsize: 11,
              ),
              content: Card(
                color: Colors.transparent,
                elevation: 0.0,
                child: widget,
              ),
              actions: [
                yes != null
                    ? CupertinoDialogAction(
                        child: Text(yes),
                        onPressed: () {
                          Future.delayed(
                            const Duration(milliseconds: 10),
                            () => callback(true),
                          );
                          Navigator.of(context).pop();
                        })
                    : Container(),
                no != null
                    ? CupertinoDialogAction(
                        child: Text(no),
                        onPressed: () {
                          Future.delayed(
                            const Duration(milliseconds: 10),
                            () => callback(false),
                          );
                          Navigator.of(context).pop();
                        })
                    : Container(),
              ],
            );
          },
        );
      },
    );
  }
}

void showAlertDialogotp(
    context, title, message, yes, no, Function callback, bool isValid) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: getDialogOneButtonotp(
            context, title, message, yes, no, callback, isValid),
      );
    },
    barrierDismissible: false,
  );
}

CupertinoAlertDialog getDialogOneButtonotp(
    context, title, message, yes, no, Function callback, bool isValid) {
  RenderObject.debugCheckingIntrinsics = true;
  return CupertinoAlertDialog(
    title: title != null
        ? Column(children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: isValid ? Colors.green : Colors.red,
              child: Icon(isValid ? Icons.check : Icons.close_rounded,
                  color: Colors.white, size: 28),
            ),
            SizedBox(
              height: 2,
            ),
            BoldTextWidget(title: title, fontsize: headerFontSize + 2),
            SizedBox(
              height: 2,
            ),
            message != null
                ? Html(
                    data: message.toString(),
                    shrinkWrap: true,
                    style: {
                      "body": Style(
                        fontSize: FontSize(15.0),
                        color: Colors.grey,
                        // fontFamily: FONT_STYLE_QUICK_REGULAR,
                        textAlign: TextAlign.center,
                      ),
                    },
                  )
                : Container(),
            SizedBox(
              height: 3,
            ),
            GestureDetector(
              onTap: () {
                Future.delayed(
                  const Duration(milliseconds: 10),
                  () => callback(true),
                );
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 50, left: 50, top: 10, bottom: 10),
                  child: MediumTextWidget(
                    fontsize: 13,
                    title: yes,
                    fontcolor: Colors.white,
                  ),
                ),
              ),
            ),
          ])
        : Container(),
  );
}
