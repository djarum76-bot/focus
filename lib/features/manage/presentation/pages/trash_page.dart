import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/custom_app_bar.dart';
import 'package:focus/shared/widgets/task_item.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TrashPage extends StatefulWidget{
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
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
        titleText: "Trash",
        titleStyle: AppTypography.heading4.copyWith(color: Colors.white),
        bgColor: colors.background,
        icon: LineIcons.arrowLeft,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: CupertinoScrollbar(
          controller: _scrollController,
          child: ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: 10,
            itemBuilder: (context, index) => TaskItem.trash(),
          ),
        ),
      ),
    );
  }
}