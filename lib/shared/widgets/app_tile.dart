import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum AppTileType { icon, nonIcon, timer, managing }

//ignore: must_be_immutable
class AppTile extends StatelessWidget{
  AppTile.icon({
    super.key,
    this.type = AppTileType.icon,
    required this.leadingIcon,
    required this.label,
    this.trailing
  });

  AppTile.nonIcon({
    super.key,
    this.type = AppTileType.nonIcon,
    required this.label
  });

  AppTile.timer({
    super.key,
    this.type = AppTileType.timer,
    required this.data
  });

  AppTile.managing({
    super.key,
    this.type = AppTileType.managing,
    required this.leadingIcon,
    this.trailingIcon,
    required this.label,
    this.color,
    required this.route
  });

  final AppTileType type;
  String? label;
  Map<String, String>? data;
  IconData? leadingIcon;
  IconData? trailingIcon;
  Widget? trailing;
  Color? color;
  String? route;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          if(route != null){
            Navigator.pushNamed(context, route!);
          }
        },
        child: Container(
          decoration: BoxDecoration(
              border: type == AppTileType.timer || type == AppTileType.managing ? null : Border(
                top: BorderSide(color: colors.surfaceVariant),
                bottom: BorderSide(color: colors.surfaceVariant),
              )
          ),
          margin: EdgeInsets.symmetric(horizontal: 4.5.w),
          padding: EdgeInsets.symmetric(vertical: trailing == null ? 2.h : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _appTileContent(context),
              trailing ?? Visibility(
                visible: true && (type != AppTileType.managing || trailingIcon != null),
                child: Padding(
                  padding: EdgeInsets.only(right: 4.5.w),
                  child: Icon(trailingIcon ?? LineIcons.check, color: color ?? colors.primary, size: 0.3.dp,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _appTileContent(BuildContext context){
    final colors = context.appColors;

    switch(type){
      case AppTileType.icon || AppTileType.managing:
        return Row(
          children: [
            Icon(leadingIcon, color: color ?? colors.primary, size: 0.3.dp,),
            Gap(4.w),
            Text(
              label!,
              style: AppTypography.subHeading1.copyWith(color: color ?? Colors.white),
            )
          ],
        );
      case AppTileType.nonIcon:
        return Text(
          label!,
          style: AppTypography.subHeading1,
        );
      case AppTileType.timer:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data!["title"]!,
              style: AppTypography.subHeading1,
            ),
            Gap(1.h),
            Text(
              data!["subtitle"]!,
              style: AppTypography.caption1,
            )
          ],
        );
    }
  }
}