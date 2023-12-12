import 'package:flutter/material.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CircularButton extends StatelessWidget{
  const CircularButton({super.key, required this.icon, required this.color, required this.label});
  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white,),
          ),
          Gap(1.h),
          Text(
            label,
            style: AppTypography.bodyText3,
          )
        ],
      ),
    );
  }
}