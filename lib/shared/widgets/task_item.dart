import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum TaskItemType { trash, other, completed, detail }

//ignore: must_be_immutable
class TaskItem extends StatelessWidget{
  TaskItem({
    super.key,
    this.type = TaskItemType.other,
    this.route
  });

  TaskItem.trash({
    super.key,
    this.type = TaskItemType.trash,
    this.route
  });

  TaskItem.completed({
    super.key,
    this.type = TaskItemType.completed,
    this.route
  });

  TaskItem.detail({
    super.key,
    this.type = TaskItemType.detail,
  });

  final TaskItemType type;
  String? route;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      margin: EdgeInsets.only(bottom: 2.h, left: 4.5.w, right: 4.5.w),
      child: InkWell(
        onTap: route == null ? null : () => Navigator.pushNamed(context, route!),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.surfaceVariant.withOpacity(0.25),
            borderRadius: BorderRadius.circular(12),
            border: const Border.fromBorderSide(BorderSide(color: Colors.pink, width: 2)),
          ),
          padding: EdgeInsets.fromLTRB(1.w, 0.5.h, 3.w, 0.5.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Radio(
                value: 1,
                groupValue: 1,
                onChanged: (_){},
              ),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 1.7.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Design User Experience (UX)",
                          style: AppTypography.subHeading1.copyWith(
                              decoration: type == TaskItemType.completed ? TextDecoration.lineThrough : null,
                              decorationThickness: type == TaskItemType.completed ? 4.0 : null
                          ),
                        ),
                        Visibility(
                          visible: type != TaskItemType.detail,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(1.h),
                              Wrap(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 2.w),
                                    child: Text(
                                      "#Research",
                                      style: AppTypography.inputText2.copyWith(color: Colors.amber),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 2.w),
                                    child: Text(
                                      "#Work",
                                      style: AppTypography.inputText2.copyWith(color: Colors.purple),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(1.25.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(LineIcons.stopwatch, color: colors.primary, size: 0.3.dp,),
                                      Gap(2.w),
                                      Text(
                                        "6",
                                        style: AppTypography.inputText2.copyWith(color: colors.onBackground),
                                      )
                                    ],
                                  ),
                                  Gap(4.w),
                                  Icon(LineIcons.sun, color: Colors.green, size: 0.3.dp,),
                                  Gap(4.w),
                                  Icon(LineIcons.flag, color: colors.primary, size: 0.3.dp,),
                                  Gap(4.w),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(LineIcons.briefcase, color: colors.primary, size: 0.3.dp,),
                                      Gap(2.w),
                                      Text(
                                        "NITA",
                                        style: AppTypography.inputText2.copyWith(color: colors.onBackground),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              ),
              Visibility(
                visible: type == TaskItemType.trash,
                child: PopupMenuButton(
                  color: Colors.white,
                  offset: Offset(0.0, AppBar().preferredSize.height),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(LineIcons.trashRestore, size: 0.3.dp, color: Colors.black,),
                          Gap(2.w),
                          Text("Restore", style: AppTypography.inputText1,)
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(LineIcons.trash, size: 0.3.dp, color: Colors.red,),
                          Gap(2.w),
                          Text("Delete Forever", style: AppTypography.inputText1.copyWith(color: Colors.red),)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}