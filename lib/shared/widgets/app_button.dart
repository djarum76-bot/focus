import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum AppButtonType{ common, icon }

//ignore: must_be_immutable
class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.radius,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.type = AppButtonType.common,
    this.fontSize
  });

  AppButton.icon({
    super.key,
    required this.icon,
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.radius,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.type = AppButtonType.icon,
    this.fontSize
  });

  final void Function() onTap;
  final String text;
  final AppButtonType type;
  double? width;
  double? height;
  double? radius;
  Color? backgroundColor;
  Color? borderColor;
  Color? textColor;
  IconData? icon;
  double? fontSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 6.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 32),
            side: BorderSide(color: borderColor ?? Colors.transparent),
          ),
        ),
        child: _appButtonChild(context),
      ),
    );
  }

  Widget _appButtonChild(BuildContext context){
    final colors = context.appColors;

    switch(type){
      case AppButtonType.common:
        return Text(
          text,
          style: AppTypography.heading8.copyWith(color: textColor ?? colors.onPrimary, fontSize: fontSize ?? 16),
        );
      case AppButtonType.icon:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon),
            Text(
              text,
              style: AppTypography.heading8.copyWith(color: textColor ?? colors.onPrimary, fontSize: fontSize ?? 16),
            )
          ],
        );
    }
  }
}
