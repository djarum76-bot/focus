import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:focus/main.dart';
import 'package:focus/themes/app_text_style.dart';

//ignore: must_be_immutable
class CustomAppBar extends AppBar {
  String? titleText;
  TextStyle? titleStyle;
  final Color? bgColor;
  final List<Widget>? widgets;
  Widget? lead;
  IconData? icon;
  Widget? form;
  TabBar? tabBar;

  /// App Bar
  factory CustomAppBar({
    Key? key,
    required String titleText,
    TextStyle? titleStyle,
    Color? bgColor,
    List<Widget>? widgets,
    Widget? lead,
  }) {
    return CustomAppBar._internal(
      titleText: titleText,
      titleStyle: titleStyle ?? AppTypography.heading4,
      bgColor: bgColor,
      key: key,
      widgets: widgets,
      lead: lead,
    );
  }

  CustomAppBar._internal({
    super.key,
    required this.titleText,
    required this.titleStyle,
    this.bgColor,
    this.widgets,
    this.lead,
  }) : super(
    centerTitle: true,
    elevation: 0,
    backgroundColor: bgColor ?? Colors.white.withAlpha(200),
    title: Text(
      titleText!,
      style: titleStyle,
    ),
    actions: widgets ?? <Widget>[],
    leading: lead
  );

  /// Blur App Bar
  factory CustomAppBar.blur({
    required String titleText,
    TextStyle? titleStyle,
    Key? key,
    List<Widget>? widgets,
    Widget? lead,
  }) {
    return CustomAppBar._blur(
      titleText: titleText,
      titleStyle: titleStyle ?? const TextStyle(), // Default empty style if not provided
      key: key,
      widgets: widgets,
      lead: lead,
    );
  }

  CustomAppBar._blur({
    super.key,
    required this.titleText,
    required this.titleStyle,
    this.bgColor,
    this.widgets,
    this.lead,
  }) : super(
    flexibleSpace: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(color: Colors.transparent),
      ),
    ),
    centerTitle: true,
    elevation: 0,
    backgroundColor: bgColor ?? Colors.white.withAlpha(200),
    title: Text(
      titleText!,
      style: titleStyle,
    ),
    actions: widgets ?? <Widget>[],
    leading: lead
  );

  /// App Bar Back Function
  factory CustomAppBar.back({
    Key? key,
    required String titleText,
    TextStyle? titleStyle,
    Color? bgColor,
    List<Widget>? widgets,
    required IconData icon
  }) {
    return CustomAppBar._back(
      titleText: titleText,
      titleStyle: titleStyle ?? AppTypography.heading4,
      bgColor: bgColor,
      key: key,
      widgets: widgets,
      icon: icon,
    );
  }

  CustomAppBar._back({
    super.key,
    required this.titleText,
    required this.titleStyle,
    this.bgColor,
    this.widgets,
    required this.icon
  }) : super(
      centerTitle: true,
      elevation: 0,
      backgroundColor: bgColor ?? Colors.white.withAlpha(200),
      title: Text(
        titleText!,
        style: titleStyle,
      ),
      actions: widgets ?? <Widget>[],
      leading: GestureDetector(
        onTap: () => Navigator.pop(navigatorKey.currentContext!),
        child: Icon(icon, color: Colors.white,),
      )
  );

  factory CustomAppBar.form({
    Key? key,
    required Widget form,
    Color? bgColor,
    List<Widget>? widgets,
    required IconData icon,
  }) {
    return CustomAppBar._form(
        form: form,
        bgColor: bgColor,
        key: key,
        widgets: widgets,
        icon: icon
    );
  }

  CustomAppBar._form({
    super.key,
    required this.form,
    this.bgColor,
    this.widgets,
    required this.icon
  }) : super(
      elevation: 0,
      backgroundColor: bgColor,
      title: form,
      actions: widgets ?? <Widget>[],
      leading: GestureDetector(
        onTap: () => Navigator.pop(navigatorKey.currentContext!),
        child: Icon(icon, color: Colors.white,),
      )
  );

  /// App Bar Back Function
  factory CustomAppBar.tabBar({
    Key? key,
    required String titleText,
    TextStyle? titleStyle,
    Color? bgColor,
    List<Widget>? widgets,
    required TabBar tabBar,
    required Widget lead
  }) {
    return CustomAppBar._tabBar(
        titleText: titleText,
        titleStyle: titleStyle ?? AppTypography.heading4,
        bgColor: bgColor,
        key: key,
        widgets: widgets,
        tabBar: tabBar,
        lead: lead,
    );
  }

  CustomAppBar._tabBar({
    super.key,
    required this.titleText,
    required this.titleStyle,
    this.bgColor,
    this.widgets,
    required this.tabBar,
    required this.lead
  }) : super(
      centerTitle: true,
      elevation: 0,
      backgroundColor: bgColor ?? Colors.white.withAlpha(200),
      title: Text(
        titleText!,
        style: titleStyle,
      ),
      actions: widgets ?? <Widget>[],
      leading: lead,
      bottom: tabBar
  );
}