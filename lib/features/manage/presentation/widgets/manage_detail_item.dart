import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ManageDetailItem extends StatelessWidget{
  const ManageDetailItem({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: colors.surfaceVariant.withOpacity(0.25),
            border: Border.all(color: colors.surfaceVariant)
        ),
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTypography.heading5.copyWith(color: colors.primary),
            ),
            Gap(1.h),
            Text(
              subtitle,
              style: AppTypography.bodyText2,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}