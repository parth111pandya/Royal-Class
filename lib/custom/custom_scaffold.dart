import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'custom_app_title.dart';

class CustomScaffold extends StatefulWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final String? appBarTitle;
  final bool? resizeToAvoidBottomInset;
  final EdgeInsetsGeometry? padding;
  final List<Widget>? actionsWidget;
  Color? backgroundColor;

  CustomScaffold({
    required this.body,
    this.resizeToAvoidBottomInset,
    this.bottomNavigationBar,
    this.appBarTitle,
    Key? key,
    this.padding,
    this.actionsWidget,
    this.backgroundColor,
  });

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification? overscroll) {
        overscroll!.disallowIndicator();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor:
              widget.backgroundColor ?? AppColors.UltraLightGrayColor,
          appBar: widget.appBarTitle != null
              ? CustomAppBarTitle(
                  title: widget.appBarTitle,
                  actionsWidget: widget.actionsWidget,
                )
              : null,
          body: Padding(
            padding: widget.padding ?? EdgeInsets.all(8.0),
            child: widget.body,
          ),
          bottomNavigationBar: widget.bottomNavigationBar,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        ),
      ),
    );
  }
}
