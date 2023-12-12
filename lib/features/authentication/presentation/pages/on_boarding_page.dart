import 'package:flutter/material.dart';
import 'package:focus/features/authentication/data/models/on_boarding_model.dart';
import 'package:focus/features/authentication/presentation/widgets/on_boarding_item.dart';
import 'package:focus/shared/extensions/styles_extension.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final ValueNotifier<int> _pages = ValueNotifier<int>(0);
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      body: _onBoardingBody(context),
    );
  }

  Widget _onBoardingBody(BuildContext context) {
    return SafeArea(
      child: PageView(
        controller: _pageController,
        onPageChanged: (val) => _pages.value = val,
        children: onBoardingPages.map((page) {
          return OnBoardingItem(
              size: onBoardingPages.length,
              index: onBoardingPages.indexOf(page),
              page: _pages,
              pageController: _pageController
          );
        }).toList(),
      ),
    );
  }
}
