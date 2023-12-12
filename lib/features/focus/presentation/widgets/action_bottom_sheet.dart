import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/string_extension.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/app_button.dart';
import 'package:focus/shared/widgets/app_tile.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum ActionBottomSheetType { strict, timer, ringtone }

//ignore: must_be_immutable
class ActionBottomSheet extends StatelessWidget{
  ActionBottomSheet.strict({
    super.key,
    this.type = ActionBottomSheetType.strict
  });

  ActionBottomSheet.timer({
    super.key,
    this.type = ActionBottomSheetType.timer
  });

  ActionBottomSheet.ringtone({
    super.key,
    this.type = ActionBottomSheetType.ringtone,
    required this.ringtone
  });

  final ActionBottomSheetType type;
  String? ringtone;

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
        padding: EdgeInsets.fromLTRB(0, 2.h, 0, 2.h),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.5.w),
              child: Text(
                type == ActionBottomSheetType.ringtone ? ringtone!.ringtoneTitle : "${type.name.toCapitalize} Mode",
                style: AppTypography.heading5,
              ),
            ),
            _actionBottomSheetMenu(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.5.w),
              child: Row(
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
                        onTap: () => Navigator.pop(context),
                        text: "OK"
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _actionBottomSheetMenu(BuildContext context){
    final colors = context.appColors;

    switch(type){
      case ActionBottomSheetType.strict:
        int active = 0;

        final stricts = <String>[
          "Block All Notifications",
          "Block Phone Calls",
          "Block Other Apps",
          "Lock Phone",
          "Prohibit to Exit",
        ];

        return Column(
          children: [
            Gap(1.75.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.5.w),
              child: Divider(color: colors.surfaceVariant,),
            ),
            ...stricts.map((strict){
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      strict,
                      style: AppTypography.subHeading1,
                    ),
                    Switch(
                      value: active != 0,
                      activeTrackColor: colors.primary,
                      inactiveTrackColor: colors.surfaceVariant,
                      trackOutlineColor: MaterialStateProperty.all(active != 0 ? colors.primary : colors.surfaceVariant),
                      thumbColor: MaterialStateProperty.all(Colors.white),
                      onChanged: (bool value) {},
                    )
                  ],
                ),
              );
            }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.5.w),
              child: Divider(color: colors.surfaceVariant,),
            ),
            Gap(1.5.h),
          ],
        );
      case ActionBottomSheetType.timer:
        final timers = <Map<String, String>>[
          {
            "title" : "25:00 -> 00:00",
            "subtitle" : "Start counting from 0 until time runs out."
          },
          {
            "title" : "00:00 -> ∞",
            "subtitle" : "Start counting from 0 until stopped manually."
          }
        ];

        return Column(
          children: [
            Gap(1.75.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.5.w),
              child: Divider(color: colors.surfaceVariant,),
            ),
            ...timers.map((timer){
              return AppTile.timer(data: timer);
            }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.5.w),
              child: Divider(color: colors.surfaceVariant,),
            ),
            Gap(1.5.h),
          ],
        );
      case ActionBottomSheetType.ringtone:
        final ringtones = <String>["None", "Cafe Ambiance", "Rainforest Sounds", "Beach Waves", "Forest Birds", "Mountain Stream"];

        return Column(
          children: [
            Gap(1.75.h),
            ...ringtones.map((ringtone){
              return AppTile.nonIcon(label: ringtone);
            }),
            Gap(1.5.h),
          ],
        );
    }
  }
}