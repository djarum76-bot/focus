import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/features/focus/presentation/utils/focus_painter.dart';
import 'package:focus/features/focus/presentation/blocs/focus/focus_bloc.dart';
import 'package:focus/features/focus/presentation/widgets/action_bottom_sheet.dart';
import 'package:focus/features/focus/presentation/widgets/action_menu.dart';
import 'package:focus/features/focus/presentation/widgets/circular_timer.dart';
import 'package:focus/features/focus/presentation/widgets/task_dropdown.dart';
import 'package:focus/injector.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/app_button.dart';
import 'package:focus/shared/widgets/custom_app_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FocusPage extends StatefulWidget{
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  late CountDownController _countDownController;

  @override
  void initState() {
    _countDownController = CountDownController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return BlocProvider.value(
      value: injector<FocusBloc>()..add(FocusInitialized()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colors.primary,
        appBar: CustomAppBar(
          titleText: "Focus",
          bgColor: colors.primary,
          lead: const Icon(Ionicons.stopwatch),
        ),
        body: _homeBody(context),
      ),
    );
  }

  Widget _homeBody(BuildContext context){
    final colors = context.appColors;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 1,
                  child: CustomPaint(
                    size: const Size(double.infinity, double.infinity),
                    painter: FocusPainter(colors.background),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TaskDropdown(),
                  CircularTimer(countDownController: _countDownController),
                  BlocBuilder<FocusBloc, FocusState>(
                    builder: (context, state){
                      switch(state.status){
                        case FocusStatus.initial || FocusStatus.finished:
                          return AppButton.icon(
                            icon: Iconsax.play5,
                            onTap: () => _countDownController.start(),
                            text: "Start to Focus",
                            width: 48.w
                          );
                        case FocusStatus.pause:
                          return AppButton(
                            onTap: (){
                              _countDownController.resume();
                              injector<FocusBloc>().add(FocusResume());
                            },
                            text: "Continue",
                            width: 48.w
                          );
                        default:
                          return AppButton(
                            onTap: (){
                              _countDownController.pause();
                              injector<FocusBloc>().add(FocusPaused());
                            },
                            text: "Pause",
                            width: 48.w,
                            backgroundColor: colors.background,
                            borderColor: colors.primary,
                            textColor: colors.primary
                          );
                      }
                    },
                  ),
                  BlocBuilder<FocusBloc, FocusState>(
                    builder: (context, state){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ActionMenu(onTap: ActionBottomSheet.strict(), icon: LineIcons.exclamationCircle, label: "Strict Mode"),
                          ActionMenu(onTap: ActionBottomSheet.timer(), icon: Iconsax.timer, label: "Timer Mode"),
                          ActionMenu(onTap: ActionBottomSheet.ringtone(ringtone: state.ringtone,), icon: LineIcons.music, label: state.ringtone.isEmpty ? "-" : state.ringtone),
                        ],
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}