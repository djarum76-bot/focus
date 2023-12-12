import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus/features/manage/presentation/widgets/delete_bottom_sheet.dart';
import 'package:focus/features/manage/presentation/widgets/tag_item.dart';
import 'package:focus/features/manage/presentation/widgets/task_detail_item.dart';
import 'package:focus/features/manage/presentation/widgets/task_status_item.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/app_form.dart';
import 'package:focus/shared/widgets/custom_app_bar.dart';
import 'package:focus/shared/widgets/task_item.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TaskDetailPage extends StatefulWidget{
  const TaskDetailPage({super.key});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late ScrollController _scrollController;
  final ValueNotifier<bool> _isUpload = ValueNotifier<bool>(false);

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.back(
        titleText: "Task",
        titleStyle: AppTypography.heading4.copyWith(color: Colors.white),
        bgColor: colors.background,
        icon: LineIcons.arrowLeft,
        widgets: [
          PopupMenuButton(
            color: Colors.white,
            offset: Offset(0.0, AppBar().preferredSize.height),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: (){
                  Future.delayed(const Duration(milliseconds: 100), (){
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) => const DeleteBottomSheet()
                    );
                  });
                },
                child: Row(
                  children: [
                    Icon(LineIcons.trash, size: 0.3.dp, color: Colors.red,),
                    Gap(2.w),
                    Text("Delete", style: AppTypography.inputText1.copyWith(color: Colors.red),)
                  ],
                ),
              )
            ],
          )
        ],
      ),
      body: _taskDetailBody(context),
    );
  }

  Widget _taskDetailBody(BuildContext context){
    final colors = context.appColors;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 2.h, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: CupertinoScrollbar(
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              TaskItem.detail(),
              Container(
                decoration: BoxDecoration(
                  color: colors.surfaceVariant.withOpacity(0.25),
                  border: Border.all(color: colors.surfaceVariant),
                  borderRadius: BorderRadius.circular(12)
                ),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 0),
                child: Column(
                  children: [
                    const TaskStatusItem(icon: LineIcons.stopwatch, label: "Pomodoro", data: "4", color: Colors.deepOrange),
                    Divider(color: colors.surfaceVariant,),
                    const TaskStatusItem(icon: LineIcons.calendar, label: "Due Date", data: "Today", color: Colors.green),
                    Divider(color: colors.surfaceVariant,),
                    const TaskStatusItem(icon: LineIcons.flag, label: "Priority", data: "Medium", color: Colors.orange),
                    Divider(color: colors.surfaceVariant,),
                    const TaskStatusItem(icon: LineIcons.briefcase, label: "Project", data: "Pomodoro App", color: Colors.deepOrangeAccent),
                    Gap(1.h),
                  ],
                ),
              ),
              Gap(2.h),
              Container(
                decoration: BoxDecoration(
                    color: colors.surfaceVariant.withOpacity(0.25),
                    border: Border.all(color: colors.surfaceVariant),
                    borderRadius: BorderRadius.circular(12)
                ),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    const TaskDetailItem(isCompleted: true),
                    const TaskDetailItem(isCompleted: false),
                    const TaskDetailItem(isCompleted: false),
                    AppForm.none(hintText: "Add a Task...", icon: LineIcons.plus)
                  ],
                ),
              ),
              Gap(2.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tags",
                      style: AppTypography.subHeading1,
                    ),
                    Gap(1.h),
                    Wrap(
                      children: [
                        TagItem.filter(label: "Work", color: Colors.purple),
                        TagItem.filter(label: "Design", color: Colors.blue),
                        TagItem.filter(label: "Productive", color: Colors.green),
                        TagItem.add(),
                      ],
                    )
                  ],
                ),
              ),
              Gap(2.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add a Note",
                      style: AppTypography.subHeading1,
                    ),
                    Gap(1.h),
                    AppForm.multiline(hintText: "Add a note...", borderColor: colors.surfaceVariant,)
                  ],
                ),
              ),
              Gap(2.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Attachment",
                      style: AppTypography.subHeading1,
                    ),
                    Gap(1.h),
                    ValueListenableBuilder(
                      valueListenable: _isUpload,
                      builder: (context, state, _){
                        if(state){
                          return Container(
                            decoration: BoxDecoration(
                                color: colors.surfaceVariant.withOpacity(0.25),
                                border: Border.all(color: colors.surfaceVariant),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: ListTile(
                              leading: Icon(LineIcons.file, color: colors.primary,),
                              title: Text(
                                "Design Brief - Pomodoro App.pdf",
                                style: AppTypography.subHeading2.copyWith(color: colors.onSurfaceVariant),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: GestureDetector(
                                onTap: () => _isUpload.value = false,
                                child: const Icon(LineIcons.trash, color: Colors.red,),
                              ),
                            ),
                          );
                        }else{
                          return InkWell(
                            onTap: () => _isUpload.value = true,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colors.surfaceVariant.withOpacity(0.25),
                                  border: Border.all(color: colors.surfaceVariant),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(LineIcons.fileUpload, size: 0.4.dp,),
                                    Gap(2.h),
                                    Text(
                                      "Upload",
                                      style: AppTypography.caption1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
              Gap(2.h),
            ],
          ),
        ),
      ),
    );
  }
}