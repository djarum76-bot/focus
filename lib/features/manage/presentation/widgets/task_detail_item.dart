import 'package:flutter/material.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TaskDetailItem extends StatelessWidget{
  const TaskDetailItem({super.key, required this.isCompleted});
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(1.w, 0.5.h, 3.w, 0.5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<bool>.adaptive(
              value: isCompleted,
              groupValue: true,
              onChanged: (_){},
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.7.h),
                  child: Text(
                    "Design User Experience (UX)",
                    style: AppTypography.subHeading1.copyWith(
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                        decorationThickness: isCompleted ? 4.0 : null
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}