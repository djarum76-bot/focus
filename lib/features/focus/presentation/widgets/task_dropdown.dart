import 'package:flutter/material.dart';
import 'package:focus/features/focus/presentation/widgets/task_bottom_sheet.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TaskDropdown extends StatelessWidget{
  const TaskDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(10)
      ),
      child: InkWell(
        onTap: (){
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) => const TaskBottomSheet()
          );
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 6.25.h,
                width: 1.3.w,
                margin: EdgeInsets.fromLTRB(0.5.w, 0.5.h, 0, 0.5.h),
                decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Task",
                    style: AppTypography.bodyText1.copyWith(color: colors.onSurface),
                  ),
                  Icon(LineIcons.angleDown, size: 0.275.dp)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}