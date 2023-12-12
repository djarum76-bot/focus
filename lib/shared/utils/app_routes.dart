import 'package:flutter/material.dart';
import 'package:focus/features/authentication/presentation/pages/on_boarding_page.dart';
import 'package:focus/features/authentication/presentation/pages/splash_page.dart';
import 'package:focus/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:focus/features/manage/presentation/pages/add_page.dart';
import 'package:focus/features/manage/presentation/pages/archived_page.dart';
import 'package:focus/features/manage/presentation/pages/completed_page.dart';
import 'package:focus/features/manage/presentation/pages/manage_detail_page.dart';
import 'package:focus/features/manage/presentation/pages/managing_page.dart';
import 'package:focus/features/manage/presentation/pages/search_page.dart';
import 'package:focus/features/manage/presentation/pages/task_detail_page.dart';
import 'package:focus/features/manage/presentation/pages/trash_page.dart';
import 'package:focus/themes/app_text_style.dart';

class AppRoutes{
  static const splashPage = '/splash';
  static const onBoardingPage = '/on-boarding';
  static const dashboardPage = '/dashboard';
  static const addTagPage = '/add-tag';
  static const addProjectPage = '/add-project';
  static const manageDetailTodayPage = '/manage-detail-today';
  static const manageDetailTomorrowPage = '/manage-detail-tomorrow';
  static const manageDetailWeekPage = '/manage-detail-week';
  static const manageDetailPlannedPage = '/manage-detail-planned';
  static const trashPage = '/trash';
  static const completedPage = '/completed';
  static const searchPage = '/search';
  static const taskDetailPage = '/task-detail';
  static const managingPage = '/managing';
  static const archivedProjectsPage = '/archived-projects';
  static const archivedTagsPage = '/archived-tags';

  static Route<dynamic>? onGenerateRoutes(RouteSettings settings){
    switch(settings.name){
      case splashPage:
        return _pageRouteBuilder(page: const SplashPage());
      case onBoardingPage:
        return _pageRouteBuilder(page: const OnBoardingPage());
      case dashboardPage:
        return _pageRouteBuilder(page: const DashboardPage());
      case addTagPage:
        return _pageRouteBuilder(page: const AddPage.tag());
      case addProjectPage:
        return _pageRouteBuilder(page: const AddPage.project());
      case manageDetailTodayPage:
        return _pageRouteBuilder(page: const ManageDetailPage.today());
      case manageDetailTomorrowPage:
        return _pageRouteBuilder(page: const ManageDetailPage.tomorrow());
      case manageDetailWeekPage:
        return _pageRouteBuilder(page: const ManageDetailPage.week());
      case manageDetailPlannedPage:
        return _pageRouteBuilder(page: const ManageDetailPage.planned());
      case trashPage:
        return _pageRouteBuilder(page: const TrashPage());
      case completedPage:
        return _pageRouteBuilder(page: const CompletedPage());
      case searchPage:
        return _pageRouteBuilder(page: const SearchPage());
      case taskDetailPage:
        return _pageRouteBuilder(page: const TaskDetailPage());
      case managingPage:
        return _pageRouteBuilder(page: const ManagingPage());
      case archivedProjectsPage:
        return _pageRouteBuilder(page: const ArchivedPage.projects());
      case archivedTagsPage:
        return _pageRouteBuilder(page: const ArchivedPage.tags());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Text(
              "No route defined for ${settings.name}",
              style: AppTypography.heading8.copyWith(color: const Color(0xFFE6E1E5)),
            ),
          );
        });
    }
  }

  static PageRouteBuilder<dynamic> _pageRouteBuilder({required Widget page}){
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
    );
  }
}