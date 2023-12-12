import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:focus/features/manage/presentation/widgets/manage_bottom_sheet.dart';
import 'package:focus/features/manage/presentation/widgets/manage_item.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/utils/app_routes.dart';
import 'package:focus/shared/widgets/custom_app_bar.dart';
import 'package:focus/shared/widgets/app_form.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ManagePage extends StatefulWidget{
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colors.background,
      appBar: CustomAppBar(
        titleText: "Focus",
        titleStyle: AppTypography.heading4.copyWith(color: Colors.white),
        bgColor: colors.background,
        lead: Icon(Ionicons.stopwatch, color: colors.primary,),
        widgets: [
          PopupMenuButton(
            color: Colors.white,
            offset: Offset(0.0, AppBar().preferredSize.height),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: (){
                  Future.delayed(const Duration(milliseconds: 100), () => Navigator.pushNamed(context, AppRoutes.managingPage));
                },
                child: Row(
                  children: [
                    Icon(LineIcons.briefcase, size: 0.3.dp,),
                    Gap(2.w),
                    Text("Manage Project & Tags", style: AppTypography.inputText1,)
                  ],
                ),
              )
            ],
          )
        ],
      ),
      body: _manageBody(context),
      floatingActionButton: SpeedDial(
        icon: LineIcons.plus,
        activeIcon: LineIcons.times,
        children: [
          SpeedDialChild(
            child: const Icon(LineIcons.tag),
            label: "Tags",
            backgroundColor: colors.surfaceVariant,
            foregroundColor: Colors.white,
            labelStyle: AppTypography.inputText1,
            labelBackgroundColor: colors.surfaceVariant,
            onTap: () => Navigator.pushNamed(context, AppRoutes.addTagPage)
          ),
          SpeedDialChild(
            child: const Icon(LineIcons.briefcase),
            label: "Project",
            backgroundColor: colors.surfaceVariant,
            foregroundColor: Colors.white,
            labelStyle: AppTypography.inputText1,
            labelBackgroundColor: colors.surfaceVariant,
            onTap: () => Navigator.pushNamed(context, AppRoutes.addProjectPage)
          ),
          SpeedDialChild(
            child: const Icon(LineIcons.fileUpload),
            label: "Task",
            backgroundColor: colors.surfaceVariant,
            foregroundColor: Colors.white,
            labelStyle: AppTypography.inputText1,
            labelBackgroundColor: colors.surfaceVariant,
            onTap: (){
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => const ManageBottomSheet()
              );
            }
          )
        ],
      ),
    );
  }

  Widget _manageBody(BuildContext context){
    final colors = context.appColors;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(0, 2.h, 4.w, 0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: AppForm.search(
                hintText: "Search",
                focus: _focusNode,
                onTap: (){
                  _focusNode.unfocus();
                  Navigator.pushNamed(context, AppRoutes.searchPage);
                },
              ),
            ),
            Gap(2.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        ManageItem.withTime(color: Colors.green, icon: LineIcons.sun, title: "Today", subtitle: "6h 25m (4)", route: AppRoutes.manageDetailTodayPage,),
                        ManageItem.withTime(color: Colors.blue, icon: LineIcons.cloudWithSun, title: "Tomorrow", subtitle: "6h 25m (4)", route: AppRoutes.manageDetailTomorrowPage,),
                        ManageItem.withTime(color: Colors.orange, icon: LineIcons.calendarTimes, title: "This Week", subtitle: "6h 25m (4)", route: AppRoutes.manageDetailWeekPage,),
                        ManageItem.withTime(color: Colors.purple, icon: LineIcons.calendarCheck, title: "Planned", subtitle: "6h 25m (4)", route: AppRoutes.manageDetailPlannedPage,),
                        ManageItem(color: Colors.green, icon: LineIcons.checkCircle, title: "Completed", route: AppRoutes.completedPage,),
                        ManageItem(color: Colors.redAccent, icon: LineIcons.trash, title: "Trash", route: AppRoutes.trashPage,),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        children: [
                          Text(
                            "Projects",
                            style: AppTypography.caption1.copyWith(color: colors.onSurfaceVariant),
                          ),
                          Gap(5.w),
                          Expanded(child: Divider(color: colors.surfaceVariant,))
                        ],
                      ),
                    ),
                    Gap(1.5.h),
                    Wrap(
                      children: [
                        ManageItem.withTime(color: colors.primary, icon: LineIcons.briefcase, title: "Pomodoro App", subtitle: "6h 25m (4)",),
                        ManageItem.withTime(color: colors.primary, icon: LineIcons.briefcase, title: "Pomodoro App", subtitle: "6h 25m (4)",),
                        ManageItem.withTime(color: colors.primary, icon: LineIcons.briefcase, title: "Pomodoro App", subtitle: "6h 25m (4)",),
                        ManageItem.withTime(color: colors.primary, icon: LineIcons.briefcase, title: "Pomodoro App", subtitle: "6h 25m (4)",),
                        ManageItem.withTime(color: colors.primary, icon: LineIcons.briefcase, title: "Pomodoro App", subtitle: "6h 25m (4)",),
                        ManageItem.withTime(color: colors.primary, icon: LineIcons.briefcase, title: "Pomodoro App", subtitle: "6h 25m (4)",),
                        ManageItem.withTime(color: colors.primary, icon: LineIcons.briefcase, title: "Pomodoro App", subtitle: "6h 25m (4)",),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}