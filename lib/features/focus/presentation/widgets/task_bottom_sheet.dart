import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/features/dashboard/data/models/dashboard_model.dart';
import 'package:focus/features/dashboard/presentation/cubits/dashboard_cubit.dart';
import 'package:focus/shared/widgets/task_item.dart';
import 'package:focus/injector.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/app_form.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TaskBottomSheet extends StatefulWidget{
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  late ScrollController _scrollController;
  late TextEditingController _search;
  late ValueNotifier<String> _text;

  @override
  void initState() {
    _scrollController = ScrollController();
    _search = TextEditingController();
    _text = ValueNotifier<String>("");
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
        padding: EdgeInsets.fromLTRB(0, 2.h, 0, MediaQuery.of(context).viewInsets.bottom),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(LineIcons.plus, color: colors.background,),
                  Text(
                    "Select Task",
                    style: AppTypography.heading5,
                  ),
                  BlocBuilder<DashboardCubit, DashboardModel>(
                    builder: (context, state){
                      return GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          injector<DashboardCubit>().changePage(1);

                          state.pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutQuad,
                          );
                        },
                        child: Icon(LineIcons.plus, color: colors.primary,),
                      );
                    },
                  )
                ],
              ),
            ),
            Gap(1.75.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.5.w),
              child: Divider(color: colors.surfaceVariant,),
            ),
            Gap(1.5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.5.w),
              child: AppForm.search(
                hintText: "Search task...",
                controller: _search,
                text: _text,
                onFieldSubmitted: (value) => _text.value = value,
                onChanged: (value){
                  if(value.isEmpty){
                    _text.value = value;
                  }
                },
                onDelete: (value) => _text.value = value,
              ),
            ),
            Gap(1.5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.5.w),
              child: Row(
                children: [
                  Text(
                    "Today Tasks",
                    style: AppTypography.caption1.copyWith(color: colors.onSurfaceVariant),
                  ),
                  Gap(5.w),
                  Expanded(child: Divider(color: colors.surfaceVariant,))
                ],
              ),
            ),
            Gap(1.5.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: CupertinoScrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  controller: _scrollController,
                  itemCount: 10,
                  itemBuilder: (context, index){
                    return TaskItem();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}