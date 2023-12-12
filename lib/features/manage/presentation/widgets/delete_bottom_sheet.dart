import 'package:flutter/material.dart';
import 'package:focus/features/manage/presentation/widgets/delete_success_bottom_sheet.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/app_button.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DeleteBottomSheet extends StatelessWidget{
  const DeleteBottomSheet({super.key});

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
            Gap(2.h),
            Text(
              "Delete Task",
              style: AppTypography.heading5.copyWith(color: colors.primary),
            ),
            Gap(1.5.h),
            Divider(color: colors.surfaceVariant,),
            Gap(2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                'Are you sure you want to delete the "Design User Experience (UX)" task?',
                style: AppTypography.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            Gap(2.h),
            Divider(color: colors.surfaceVariant,),
            Gap(2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppButton(
                    onTap: () => Navigator.pop(context),
                    text: "Cancel",
                    backgroundColor: colors.onSecondary,
                    textColor: colors.onSecondaryContainer,
                  ),
                ),
                Gap(4.w),
                Expanded(
                  child: AppButton(
                      onTap: (){
                        ///calling success
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) => const DeleteSuccessBottomSheet()
                        );

                        ///pop from task detail page
                        Future.delayed(const Duration(seconds: 2), (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      },
                      text: "Yes, Delete"
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}