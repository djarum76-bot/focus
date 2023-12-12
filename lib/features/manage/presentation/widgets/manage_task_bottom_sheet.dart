import 'package:flutter/material.dart';
import 'package:focus/features/manage/presentation/widgets/calendar_header.dart';
import 'package:focus/shared/extensions/string_extension.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/app_button.dart';
import 'package:focus/shared/widgets/app_tile.dart';
import 'package:focus/shared/widgets/circular_button.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';

enum ManageTaskBottomSheetType { date, priority, tags, project }

class ManageTaskBottomSheet extends StatefulWidget{
  const ManageTaskBottomSheet.date({
    super.key,
    this.type = ManageTaskBottomSheetType.date
  });

  const ManageTaskBottomSheet.priority({
    super.key,
    this.type = ManageTaskBottomSheetType.priority
  });

  const ManageTaskBottomSheet.tags({
    super.key,
    this.type = ManageTaskBottomSheetType.tags
  });

  const ManageTaskBottomSheet.project({
    super.key,
    this.type = ManageTaskBottomSheetType.project
  });

  final ManageTaskBottomSheetType type;

  @override
  State<ManageTaskBottomSheet> createState() => _ManageTaskBottomSheetState();
}

class _ManageTaskBottomSheetState extends State<ManageTaskBottomSheet> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

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
                widget.type.name.toCapitalize,
                style: AppTypography.heading5,
              ),
            ),
            _manageTaskBottomSheetMenu(context),
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

  Widget _manageTaskBottomSheetMenu(BuildContext context){
    final ValueNotifier<DateTime> selectedDay = ValueNotifier(DateTime.now());
    final colors = context.appColors;

    switch(widget.type){
      case ManageTaskBottomSheetType.date:
        return Column(
          children: [
            Gap(1.75.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.5.w),
              child: Divider(color: colors.surfaceVariant,),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularButton(icon: LineIcons.sun, color: Colors.green, label: "Today"),
                CircularButton(icon: LineIcons.sun, color: Colors.blue, label: "Tomorrow"),
                CircularButton(icon: LineIcons.sun, color: Colors.purple, label: "This Week"),
                CircularButton(icon: LineIcons.sun, color: Colors.red, label: "Planned"),
              ],
            ),
            Gap(1.h),
            ValueListenableBuilder<DateTime>(
              valueListenable: selectedDay,
              builder: (context, value, _) {
                return CalendarHeader(
                  focusedDay: value,
                  onLeftArrowTap: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                  onRightArrowTap: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                );
              },
            ),
            ValueListenableBuilder<DateTime>(
              valueListenable: selectedDay,
              builder: (context, value, _){
                return TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: selectedDay.value,
                  headerVisible: false,
                  onCalendarCreated: (controller) => _pageController = controller,
                  onPageChanged: (focusedDay) => selectedDay.value = focusedDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: (day, focusedDay) => selectedDay.value = focusedDay,
                  daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: AppTypography.labelText1, weekendStyle: AppTypography.labelText1),
                  calendarStyle: CalendarStyle(defaultTextStyle: AppTypography.bodyText1, weekendTextStyle: AppTypography.bodyText1, selectedTextStyle: AppTypography.bodyText1),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.5.w),
              child: Divider(color: colors.surfaceVariant,),
            ),
            Gap(1.5.h),
          ],
        );
      case ManageTaskBottomSheetType.priority:
        final priorities = <String>["High", "Medium", "Low", "No"];

        return Column(
          children: [
            Gap(1.75.h),
            ...priorities.map((priority){
              return AppTile.icon(leadingIcon: LineIcons.flag, label: "$priority Priority");
            }),
            Gap(1.5.h),
          ],
        );
      case ManageTaskBottomSheetType.tags:
        final tags = <String>["Urgent", "Personal", "Work", "Home"];

        return Column(
          children: [
            Gap(1.75.h),
            ...tags.map((tag){
              return AppTile.icon(leadingIcon: LineIcons.tag, label: tag);
            }),
            Gap(1.5.h),
          ],
        );
      case ManageTaskBottomSheetType.project:
        final projects = <String>["General", "Pomodoro App", "Fashion App", "AI Chatbot App", "Dating App", "Quiz App"];

        return Column(
          children: [
            Gap(1.75.h),
            ...projects.map((project){
              return AppTile.icon(leadingIcon: LineIcons.briefcase, label: project);
            }),
            Gap(1.5.h),
          ],
        );
    }
  }
}