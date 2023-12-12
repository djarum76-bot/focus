import 'package:flutter/material.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchHistoryItem extends StatelessWidget{
  const SearchHistoryItem({super.key, required this.label, required this.text, required this.search});
  final String label;
  final ValueNotifier<String> text;
  final TextEditingController search;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          text.value = label;
          search.text = label;
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.5.w),
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTypography.bodyText1,
              ),
              InkWell(
                onTap: (){},
                child: Icon(LineIcons.times, color: Colors.white, size: 0.3.dp,),
              )
            ],
          ),
        ),
      ),
    );
  }
}