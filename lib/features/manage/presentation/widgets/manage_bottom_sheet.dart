import 'package:flutter/material.dart';
import 'package:focus/features/manage/presentation/widgets/manage_task_bottom_sheet.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/app_button.dart';
import 'package:focus/shared/widgets/app_form.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ManageBottomSheet extends StatefulWidget{
  const ManageBottomSheet({super.key});

  @override
  State<ManageBottomSheet> createState() => _ManageBottomSheetState();
}

class _ManageBottomSheetState extends State<ManageBottomSheet> {
  final ValueNotifier<int> _number = ValueNotifier<int>(5);

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
        padding: EdgeInsets.fromLTRB(4.5.w, 2.h, 4.5.w, MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppForm.underline(hintText: "Add a Task..."),
            Gap(3.h),
            Text(
              "Estimated Pomodoros",
              style: AppTypography.caption1.copyWith(color: colors.onSurfaceVariant),
            ),
            Gap(2.h),
            ValueListenableBuilder(
              valueListenable: _number,
              builder: (context, value, _){
                return NumberPicker(
                  value: _number.value,
                  minValue: 1,
                  maxValue: 25,
                  axis: Axis.horizontal,
                  itemWidth: 10.25.w,
                  itemHeight: 3.h,
                  itemCount: 10,
                  onChanged: (value) => _number.value = value,
                  textStyle: AppTypography.subHeading2.copyWith(color: colors.outline),
                  selectedTextStyle: AppTypography.subHeading1.copyWith(color: colors.primary),
                );
              },
            ),
            Gap(2.h),
            Divider(color: colors.surfaceVariant,),
            Gap(2.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _actionIconButton(onTap: const ManageTaskBottomSheet.date(), icon: LineIcons.sun, isActive: true, color: Colors.green),
                      _actionIconButton(onTap: const ManageTaskBottomSheet.priority(), icon: LineIcons.flag, isActive: false, color: Colors.orange),
                      _actionIconButton(onTap: const ManageTaskBottomSheet.tags(), icon: LineIcons.tag, isActive: false, color: Colors.blue),
                      _actionIconButton(onTap: const ManageTaskBottomSheet.project(), icon: LineIcons.briefcase, isActive: true, color: Colors.deepOrange),
                    ],
                  ),
                ),
                AppButton(
                  width: 30.w,
                  height: 5.h,
                  onTap: () => Navigator.pop(context),
                  text: "Add"
                )
              ],
            ),
            Gap(2.h),
          ],
        ),
      ),
    );
  }

  Widget _actionIconButton({required Widget onTap, required IconData icon, required bool isActive, required Color color}){
    return Padding(
      padding: EdgeInsets.only(right: 6.w),
      child: GestureDetector(
        onTap: (){
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) => onTap
          );
        },
        child: Icon(icon, color: isActive ? color : Colors.white),
      ),
    );
  }
}