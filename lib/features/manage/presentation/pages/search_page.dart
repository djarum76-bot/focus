import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus/shared/widgets/task_item.dart';
import 'package:focus/features/manage/presentation/widgets/search_history_item.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/app_form.dart';
import 'package:focus/shared/widgets/custom_app_bar.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late ScrollController _scrollController;
  late TextEditingController _search;
  late ValueNotifier<String> _text;
  String data = "data";

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

    return Scaffold(
      appBar: CustomAppBar.form(
        form: AppForm.search(
          hintText: "Search",
          vertical: 1.h,
          autoFocus: true,
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
        icon: LineIcons.arrowLeft,
        bgColor: colors.background,
      ),
      body: _searchBody(context),
    );
  }

  Widget _searchBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(0, 2.h, 0, 0),
        child: ValueListenableBuilder(
          valueListenable: _text,
          builder: (context, text, _){
            if(text == ""){
              return CupertinoScrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemCount: 20,
                  itemBuilder: (context, index){
                    return SearchHistoryItem(label: "Create a Feature List", text: _text, search: _search,);
                  },
                ),
              );
            }

            if(text == data){
              return CupertinoScrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  controller: _scrollController,
                  itemCount: 10,
                  itemBuilder: (context, index){
                    return TaskItem();
                  },
                ),
              );
            }else{
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.menu_board, size: 1.dp,),
                  Gap(4.h),
                  Text(
                    "No Task Found",
                    style: AppTypography.heading4,
                  ),
                  Gap(1.h),
                  Text(
                    "Please try searching with other keywords.",
                    style: AppTypography.bodyText2,
                    textAlign: TextAlign.center,
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}