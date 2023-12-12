import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus/features/manage/presentation/widgets/manage_bottom_sheet.dart';
import 'package:focus/features/manage/presentation/widgets/manage_detail_item.dart';
import 'package:focus/shared/extensions/string_extension.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/utils/app_routes.dart';
import 'package:focus/shared/widgets/app_form.dart';
import 'package:focus/shared/widgets/custom_app_bar.dart';
import 'package:focus/shared/widgets/task_item.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum ManageDetailType { today, tomorrow, week, planned }

class ManageDetailPage extends StatefulWidget{
  const ManageDetailPage.today({
    super.key,
    this.type = ManageDetailType.today
  });

  const ManageDetailPage.tomorrow({
    super.key,
    this.type = ManageDetailType.tomorrow
  });

  const ManageDetailPage.week({
    super.key,
    this.type = ManageDetailType.week
  });

  const ManageDetailPage.planned({
    super.key,
    this.type = ManageDetailType.planned
  });

  final ManageDetailType type;

  @override
  State<ManageDetailPage> createState() => _ManageDetailPageState();
}

class _ManageDetailPageState extends State<ManageDetailPage> {
  late ScrollController _scrollController;
  late FocusNode _focusNode;

  @override
  void initState() {
    _scrollController = ScrollController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.back(
        titleText: widget.type.name.toCapitalize,
        titleStyle: AppTypography.heading4.copyWith(color: Colors.white),
        bgColor: colors.background,
        icon: LineIcons.arrowLeft,
      ),
      body: _manageDetailBody(context),
    );
  }

  Widget _manageDetailBody(BuildContext context){
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    const ManageDetailItem(title: "06:25", subtitle: "Total Podomoro Hours"),
                    Gap(4.w),
                    const ManageDetailItem(title: "06:25", subtitle: "Elapsed Time")
                  ],
                ),
              ),
              Gap(2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    const ManageDetailItem(title: "2", subtitle: "Task Waiting"),
                    Gap(4.w),
                    const ManageDetailItem(title: "2", subtitle: "Task Completed")
                  ],
                ),
              ),
              Gap(3.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: AppForm.outline(
                  hintText: "Add a Task...",
                  icon: LineIcons.plus,
                  borderColor: colors.surfaceVariant,
                  focus: _focusNode,
                  onTap: (){
                    _focusNode.unfocus();

                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) => const ManageBottomSheet()
                    );
                  },
                ),
              ),
              Gap(3.h),
              Wrap(
                children: _manageDetailItemList(false),
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
              Gap(2.h),
              Wrap(
                children: _manageDetailItemList(true),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _manageDetailItemList(bool completed){
    List<Widget> widgets = <Widget>[];

    for(int i = 0; i < 2; i++){
      widgets.add(completed ? TaskItem.completed() : TaskItem(route: AppRoutes.taskDetailPage,));
    }

    return widgets;
  }
}