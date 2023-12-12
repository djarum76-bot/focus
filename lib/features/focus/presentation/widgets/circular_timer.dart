import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/features/focus/presentation/blocs/focus/focus_bloc.dart';
import 'package:focus/features/focus/presentation/widgets/congratulation_dialog.dart';
import 'package:focus/injector.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CircularTimer extends StatelessWidget{
  const CircularTimer({super.key, required this.countDownController});
  final CountDownController countDownController;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final validStatus = [FocusStatus.start, FocusStatus.pause, FocusStatus.resume];

    return Container(
      width: double.infinity,
      height: 37.5.h,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.onSecondary
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(0.4.dp),
            child: BlocBuilder<FocusBloc, FocusState>(
              builder: (context, state){
                return CircularCountDownTimer(
                  duration: state.duration,
                  initialDuration: 0,
                  controller: countDownController,
                  width: 25.w,
                  height: 25.h,
                  ringColor: validStatus.contains(state.status) ? colors.surface : colors.primary,
                  fillColor: colors.primary,
                  backgroundColor: colors.onSecondary,
                  strokeWidth: 25.0,
                  strokeCap: StrokeCap.round,
                  textStyle: AppTypography.heading1,
                  textFormat: CountdownTextFormat.MM_SS,
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  autoStart: false,
                  onStart: () => injector<FocusBloc>().add(FocusStarted()),
                  onComplete: (){
                    countDownController.reset();
                    injector<FocusBloc>().add(FocusFinished());

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const CongratulationDialog()
                    );
                  },
                  timeFormatterFunction: (defaultFormatterFunction, duration) => Function.apply(defaultFormatterFunction, [duration]),
                );
              },
            ),
          ),
          Positioned.fill(
            top: 9.h,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "No sessions",
                style: AppTypography.bodyText3,
              ),
            ),
          )
        ],
      ),
    );
  }
}