import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/utils/app_routes.dart';
import 'package:focus/shared/widgets/app_tile.dart';
import 'package:focus/shared/widgets/custom_app_bar.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ManagingPage extends StatefulWidget{
  const ManagingPage({super.key});

  @override
  State<ManagingPage> createState() => _ManagingPageState();
}

class _ManagingPageState extends State<ManagingPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar.tabBar(
          titleText: "Manage Project & Tags",
          titleStyle: AppTypography.heading4.copyWith(color: Colors.white),
          bgColor: colors.background,
          lead: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(LineIcons.arrowLeft, color: Colors.white,),
          ),
          tabBar: TabBar(
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8), // Creates border
                color: colors.primary
            ),
            indicatorColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: AppTypography.subHeading3,
            labelColor: colors.onPrimary,
            unselectedLabelColor: colors.secondary,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            tabs: const [
              Tab(text: "Project",),
              Tab(text: "Tags",),
            ],
          ),
        ),
        body: _managingBody(context),
      ),
    );
  }

  Widget _managingBody(BuildContext context){
    final colors = context.appColors;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 1.h),
        child: TabBarView(
          children: [
            CupertinoScrollbar(
              controller: _scrollController,
              child: ListView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                children: [
                  AppTile.managing(leadingIcon: LineIcons.plus, label: "Add Project", color: colors.primary, route: AppRoutes.addProjectPage,),
                  ..._managingItemList(true),
                  AppTile.managing(leadingIcon: LineIcons.archiveFile, label: "Archived Projects", color: Colors.white, trailingIcon: LineIcons.angleRight, route: AppRoutes.archivedProjectsPage),
                ],
              ),
            ),
            CupertinoScrollbar(
              controller: _scrollController,
              child: ListView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                children: [
                  AppTile.managing(leadingIcon: LineIcons.plus, label: "Add Tags", color: colors.primary, route: AppRoutes.addTagPage),
                  ..._managingItemList(false),
                  AppTile.managing(leadingIcon: LineIcons.archiveFile, label: "Archived Tags", color: Colors.white, trailingIcon: LineIcons.angleRight, route: AppRoutes.archivedTagsPage),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _managingItemList(bool isProject){
    List<Widget> list = <Widget>[];

    for(int i = 0; i < 20; i++){
      list.add(AppTile.icon(
        leadingIcon: isProject ? LineIcons.briefcase : LineIcons.tag,
        label: isProject ? "News App" : "Personal",
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
                  Icon(LineIcons.edit, size: 0.3.dp, color: Colors.black,),
                  Gap(2.w),
                  Text("Edit", style: AppTypography.inputText1,)
                ],
              ),
            ),
            PopupMenuItem(
              onTap: (){},
              child: Row(
                children: [
                  Icon(LineIcons.archiveFile, size: 0.3.dp, color: Colors.black),
                  Gap(2.w),
                  Text("Archive", style: AppTypography.inputText1,)
                ],
              ),
            )
          ],
        ),
      ));
    }

    return list;
  }
}