import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/features/dashboard/data/models/dashboard_model.dart';
import 'package:focus/features/dashboard/presentation/cubits/dashboard_cubit.dart';
import 'package:focus/features/calendar/presentation/pages/calendar_page.dart';
import 'package:focus/features/focus/presentation/blocs/focus/focus_bloc.dart';
import 'package:focus/features/focus/presentation/pages/focus_page.dart';
import 'package:focus/features/manage/presentation/pages/manage_page.dart';
import 'package:focus/features/dashboard/presentation/pages/report_page.dart';
import 'package:focus/injector.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/exit_dialog.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class DashboardPage extends StatefulWidget{
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late List<Widget> _pages;

  @override
  void initState() {
    _pages = <Widget>[
      const FocusPage(),
      const ManagePage(),
      const CalendarPage(),
      const ReportPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<FocusBloc>(),
      child: WillPopScope(
        onWillPop: ()async{
          return await showDialog(context: context, builder: (context) => const ExitDialog());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _dashboardBody(context),
          bottomNavigationBar: _dashboardBottomNavBar(context),
        ),
      ),
    );
  }

  Widget _dashboardBody(context){
    return BlocBuilder<DashboardCubit, DashboardModel>(
      builder: (context, state){
        return PageView(
          controller: state.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        );
      },
    );
  }

  Widget _dashboardBottomNavBar(BuildContext context){
    final colors = context.appColors;

    return BlocBuilder<DashboardCubit, DashboardModel>(
      builder: (context, state){
        return SlidingClippedNavBar(
          backgroundColor: colors.background,
          onButtonPressed: (index) {
            if(state.page != index){
              injector<DashboardCubit>().changePage(index);

              state.pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutQuad
              );
            }
          },
          iconSize: 30,
          activeColor: colors.onBackground,
          inactiveColor: colors.onSecondary,
          selectedIndex: state.page,
          barItems: [
            BarItem(
              icon: LineIcons.clock,
              title: 'Focus',
            ),
            BarItem(
              icon: Icons.window_outlined,
              title: 'Manage',
            ),
            BarItem(
              icon: Ionicons.calendar_outline,
              title: 'Calendar',
            ),
            BarItem(
              icon: Iconsax.chart,
              title: 'Report',
            ),
          ],
        );
      },
    );
  }
}