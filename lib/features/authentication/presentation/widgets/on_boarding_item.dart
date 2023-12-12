import 'package:flutter/material.dart';
import 'package:focus/features/authentication/data/models/on_boarding_model.dart';
import 'package:focus/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:focus/features/authentication/presentation/utils/on_boarding_painter.dart';
import 'package:focus/injector.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/utils/app_routes.dart';
import 'package:focus/shared/widgets/app_button.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem(
      {super.key,
      required this.size,
      required this.index,
      required this.page,
      required this.pageController});

  final int size;
  final int index;
  final ValueNotifier<int> page;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: colors.background,
      child: Column(
        children: [
          Align(
            child: CustomPaint(
              size: Size(double.infinity, 50.h),
              painter: OnBoardingPainter(colors.primary),
            ),
          ),
          Expanded(
            child: Container(
              color: colors.background,
              padding: EdgeInsets.fromLTRB(0, 3.h, 0, 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: Text(
                      onBoardingPages[index].title,
                      style: AppTypography.heading3.copyWith(height: 1.4),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: Text(
                      onBoardingPages[index].description,
                      style: AppTypography.bodyText1.copyWith(height: 1.6),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SmoothPageIndicator(
                      controller: pageController, // PageController
                      count: size,
                      effect: ExpandingDotsEffect(activeDotColor: colors.primary, dotColor: colors.secondary), // your preferred effect
                      onDotClicked: (index) {}),
                  Divider(color: colors.outline.withOpacity(0.5),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: ValueListenableBuilder<int>(
                      valueListenable: page,
                      builder: (BuildContext context, state, _){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if(state != 2)
                              Expanded(
                                child: AppButton(
                                  onTap: (){
                                    pageController.animateToPage(
                                        2,
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.ease
                                    );
                                  },
                                  text: "Skip",
                                  backgroundColor: colors.onSecondary,
                                  textColor: colors.onSecondaryContainer,
                                ),
                              ),
                            if(state != 2)
                              Gap(4.w),
                            Expanded(
                              child: AppButton(
                                  onTap: (){
                                    if(state != 2){
                                      pageController.animateToPage(
                                          state + 1,
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.ease
                                      );
                                    }else{
                                      injector<AuthenticationRepository>().writeAppEntry().then((_){
                                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboardPage, (route) => false);
                                      });
                                    }
                                  },
                                  text: state != 2 ? "Continue" : "Get Started"
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
