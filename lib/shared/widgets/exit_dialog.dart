import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/app_button.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ExitDialog extends StatelessWidget{
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Dialog(
      backgroundColor: colors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 2.5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Warning",
                style: AppTypography.heading2,
                textAlign: TextAlign.center,
              ),
              Gap(2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Text(
                  "Are you sure you want to exit the application ?",
                  style: AppTypography.subHeading2,
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(2.h),
              AppButton(
                onTap: () => SystemNavigator.pop(animated: true),
                text: "Yes",
                backgroundColor: colors.primary,
                textColor: colors.onPrimary,
              ),
              Gap(2.h),
              AppButton(
                onTap: () => Navigator.pop(context),
                text: "Cancel",
                backgroundColor: colors.background,
                textColor: colors.onBackground,
              )
            ],
          ),
        ),
      ),
    );
  }
}