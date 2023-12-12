import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../themes/app_text_style.dart';

class ActionMenu extends StatelessWidget{
  const ActionMenu({super.key, required this.onTap, required this.icon, required this.label});
  final Widget onTap;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) => onTap
        );
      },
      child: SizedBox(
        width: 30.w,
        child: Column(
          children: [
            Icon(icon, size: 0.4.dp,),
            Gap(1.5.h),
            Text(
              label,
              style: AppTypography.bodyText3,
            )
          ],
        ),
      ),
    );
  }
}