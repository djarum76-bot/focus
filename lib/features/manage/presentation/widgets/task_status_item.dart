import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TaskStatusItem extends StatelessWidget{
  const TaskStatusItem({super.key, required this.icon, required this.label, required this.data, required this.color});
  final IconData icon;
  final String label;
  final String data;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(0, 1.6.h, 0, 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, color: colors.onSurfaceVariant,),
                Gap(3.w),
                Text(
                  label,
                  style: AppTypography.subHeading2.copyWith(color: colors.onSurfaceVariant),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  data,
                  style: AppTypography.subHeading2,
                ),
                Gap(3.w),
                Icon(icon, color: color,)
              ],
            ),
          )
        ],
      ),
    );
  }
}