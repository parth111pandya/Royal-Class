// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/const.dart';

class CustomTabBar extends StatefulWidget {
  List<Widget>? tab;
  List<Widget>? tabView;
  late TabController tabController;
  bool? isScrollable;
  Widget? widgetbttabandtabview;
  double? tabHeight;
  EdgeInsetsGeometry? margin;

  CustomTabBar({
    this.tab,
    this.tabView,
    this.isScrollable,
    required this.tabController,
    this.widgetbttabandtabview,
    this.tabHeight,
    this.margin,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.tabHeight ?? 5,
          width: 100,
          margin: widget.margin ?? const EdgeInsets.all(0),
          decoration: const BoxDecoration(
            color: AppColors.TabBarBGColour,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: TabBar(
            isScrollable: widget.isScrollable!,
            controller: widget.tabController,
            tabs: widget.tab!,
            indicatorPadding: const EdgeInsets.all(3),
            indicator: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              color: Colors.white,
            ),
            labelColor: AppColors.TabBarBGColour,
            unselectedLabelColor: Colors.white54,
            labelStyle: TextStyle(
              fontSize: regularFontSize,
              fontFamily: FONT_STYLE_QUICK_BOLD,
              color: AppColors.PrimaryDarkColor,
            ),
          ),
        ),
        widget.widgetbttabandtabview ?? SizedBox(height: 1),
        Expanded(
          child: TabBarView(
            controller: widget.tabController,
            children: widget.tabView!,
          ),
        ),
      ],
    );
  }
}
