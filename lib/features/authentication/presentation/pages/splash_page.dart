import 'package:flutter/material.dart';
import 'package:focus/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:focus/injector.dart';
import 'package:focus/main.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/utils/app_routes.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashPage extends StatefulWidget{
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), ()async{
      if(await injector<AuthenticationRepository>().readAppEntry()){
        Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, AppRoutes.dashboardPage, (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, AppRoutes.onBoardingPage, (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _splashBody(context),
    );
  }

  Widget _splashBody(BuildContext context){
    final colors = context.appColors;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: colors.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Ionicons.stopwatch, color: colors.onPrimary, size: 1.1.dp,),
            Gap(20.h),
            LoadingAnimationWidget.discreteCircle(color: colors.onPrimary, size: 0.5.dp)
          ],
        ),
      ),
    );
  }
}