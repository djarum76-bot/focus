import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/custom_app_bar.dart';
import 'package:focus/shared/widgets/task_item.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sticky_headers/sticky_headers.dart';

class CompletedPage extends StatefulWidget{
  const CompletedPage({super.key});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
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
      appBar: CustomAppBar.back(
        titleText: "Completed",
        titleStyle: AppTypography.heading4.copyWith(color: Colors.white),
        bgColor: colors.background,
        icon: LineIcons.arrowLeft,
      ),
      body: _completedBody(context),
    );
  }

  Widget _completedBody(BuildContext context){
    final colors = context.appColors;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 2.h),
        child: CupertinoScrollbar(
          controller: _scrollController,
          child: ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: 10,
            itemBuilder: (context, index){
              return StickyHeader(
                header: Container(
                  width: double.infinity,
                  color: colors.background,
                  padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Projects",
                            style: AppTypography.caption1.copyWith(color: colors.onSurfaceVariant),
                          ),
                          Gap(5.w),
                          Expanded(child: Divider(color: colors.surfaceVariant,))
                        ],
                      ),
                      Gap(1.h),
                      Row(
                        children: [
                          Text(
                            "Focus: 2h 5m",
                            style: AppTypography.caption1,
                          ),
                          Gap(4.w),
                          Text(
                            "Completed: ${index + 1} tasks",
                            style: AppTypography.caption1,
                          )
                        ],
                      ),
                      Gap(1.h),
                    ],
                  ),
                ),
                content: Wrap(
                  children: [
                    TaskItem.completed(),
                    TaskItem.completed(),
                    TaskItem.completed(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}