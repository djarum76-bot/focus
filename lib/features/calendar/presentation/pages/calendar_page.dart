import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/task_item.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../shared/widgets/custom_app_bar.dart';

class CalendarPage extends StatefulWidget{
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Calendar",
        titleStyle: AppTypography.heading4.copyWith(color: Colors.white),
        bgColor: colors.background,
        lead: Icon(Ionicons.stopwatch, color: colors.primary,),
      ),
      body: _calendarBody(context),
    );
  }

  Widget _calendarBody(BuildContext context){
    final colors = context.appColors;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 2.h),
        child: CupertinoScrollbar(
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              CalendarTimeline(
                initialDate: DateTime.now(),
                firstDate: DateTime(2019, 1, 15),
                lastDate: DateTime.now().add(const Duration(days: 1000)),
                onDateSelected: (date){},
                monthColor: colors.primary,
                showYears: true,
                dayColor: colors.primary,
                dayNameColor: colors.onPrimary,
                activeDayColor: colors.onPrimary,
                activeBackgroundDayColor: colors.primary,
                dotsColor: colors.background,
                locale: 'en_ISO',
              ),
              Gap(2.h),
              Wrap(
                children: [
                  TaskItem(),
                  TaskItem(),
                ],
              ),
              Gap(1.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    Text(
                      "Completed",
                      style: AppTypography.caption1.copyWith(color: colors.onSurfaceVariant),
                    ),
                    Gap(5.w),
                    Expanded(child: Divider(color: colors.surfaceVariant,))
                  ],
                ),
              ),
              Gap(2.5.h),
              Wrap(
                children: [
                  TaskItem.completed(),
                  TaskItem.completed(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}