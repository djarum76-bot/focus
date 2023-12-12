import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/string_extension.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/app_tile.dart';
import 'package:focus/shared/widgets/custom_app_bar.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum ArchivedPageType { projects, tags }

class ArchivedPage extends StatefulWidget{
  const ArchivedPage.projects({
    super.key,
    this.type = ArchivedPageType.projects
  });

  const ArchivedPage.tags({
    super.key,
    this.type = ArchivedPageType.tags
  });


  final ArchivedPageType type;

  @override
  State<ArchivedPage> createState() => _ArchivedPageState();
}

class _ArchivedPageState extends State<ArchivedPage> {
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
        titleText: "Archived ${widget.type.name.toCapitalize}",
        titleStyle: AppTypography.heading4.copyWith(color: Colors.white),
        bgColor: colors.background,
        icon: LineIcons.arrowLeft,
      ),
      body: _archivedBody(context),
    );
  }

  Widget _archivedBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 2.h),
        child: CupertinoScrollbar(
          controller: _scrollController,
          child: ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: 20,
            itemBuilder: (context, index){
              return AppTile.icon(
                leadingIcon: widget.type == ArchivedPageType.projects ? LineIcons.briefcase : LineIcons.tag,
                label: widget.type == ArchivedPageType.projects ? "News App" : "Personal",
                trailing: PopupMenuButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  offset: Offset(0.0, AppBar().preferredSize.height),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: (){},
                      child: Row(
                        children: [
                          Icon(LineIcons.trashRestore, size: 0.3.dp, color: Colors.black,),
                          Gap(2.w),
                          Text("Restore", style: AppTypography.inputText1,)
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: (){},
                      child: Row(
                        children: [
                          Icon(LineIcons.archiveFile, size: 0.3.dp, color: Colors.red),
                          Gap(2.w),
                          Text("Delete Forever", style: AppTypography.inputText1.copyWith(color: Colors.red),)
                        ],
                      ),
                    )
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