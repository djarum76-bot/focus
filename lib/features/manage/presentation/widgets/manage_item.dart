import 'package:flutter/material.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

//ignore: must_be_immutable
class ManageItem extends StatelessWidget{
  ManageItem({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    this.route
  });

  ManageItem.withTime({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.route
  });

  final Color color;
  final IconData icon;
  final String title;
  String? subtitle;
  String? route;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4.w, bottom: 2.h),
      child: InkWell(
        onTap: route == null ? null : () => Navigator.pushNamed(context, route!),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 44.w,
          decoration: BoxDecoration(
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(12)
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 0.3.dp,),
                  Gap(2.w),
                  Text(
                    title,
                    style: AppTypography.inputText2.copyWith(color: color, fontSize: 16),
                  )
                ],
              ),
              if(subtitle != null)
                Gap(1.5.h),
              if(subtitle != null)
                Text(
                  subtitle!,
                  style: AppTypography.heading6,
                )
            ],
          ),
        ),
      ),
    );
  }
}