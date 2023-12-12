import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/app_button.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lottie/lottie.dart';

class CongratulationDialog extends StatelessWidget{
  const CongratulationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        backgroundColor: colors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(4.5.w, 0, 4.5.w, 2.5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset("assets/lottie/congratulation.json"),
                Text(
                  "Congratulations!",
                  style: AppTypography.heading5,
                ),
                Gap(1.5.h),
                Text(
                  "You've completed the task\n\"Create a Design Wireframe\"",
                  style: AppTypography.inputText2,
                  textAlign: TextAlign.center,
                ),
                Gap(4.h),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onTap: () => Navigator.pop(context),
                        text: "Back to Home",
                        height: 4.25.h,
                        backgroundColor: colors.onSecondary,
                        textColor: colors.onBackground,
                        fontSize: 13,
                      )
                    ),
                    Gap(2.w),
                    Expanded(
                      child: AppButton(
                        onTap: (){},
                        text: "View Report",
                        height: 4.25.h,
                        textColor: colors.onPrimary,
                        fontSize: 13,
                      )
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}