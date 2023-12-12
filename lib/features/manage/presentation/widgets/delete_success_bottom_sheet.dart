import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DeleteSuccessBottomSheet extends StatelessWidget{
  const DeleteSuccessBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: colors.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            )
        ),
        padding: EdgeInsets.fromLTRB(4.5.w, 2.h, 4.5.w, 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 8.w,
              height: 0.3.h,
              decoration: BoxDecoration(
                  color: colors.outline.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(8)
              ),
            ),
            Gap(2.5.h),
            CircleAvatar(
              backgroundColor: colors.primary,
              radius: 0.325.dp,
              child: const Center(
                child: Icon(LineIcons.check, color: Colors.white,),
              ),
            ),
            Gap(2.h),
            Text(
              'Task has been deleted!',
              style: AppTypography.bodyText1,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}