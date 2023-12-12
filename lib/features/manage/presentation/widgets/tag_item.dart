import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum TagItemType { filter, add }

//ignore: must_be_immutable
class TagItem extends StatelessWidget{
  TagItem.filter({
    super.key,
    required this.label,
    required this.color,
    this.type = TagItemType.filter
  });

  TagItem.add({
    super.key,
    this.type = TagItemType.add
  });

  String? label;
  Color? color;
  final TagItemType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      margin: EdgeInsets.only(right: 2.w),
      child: Chip(
        backgroundColor: colors.background,
        label: Text(
          type == TagItemType.filter ? "#$label" : "+",
          style: AppTypography.inputText2.copyWith(color: color),
        ),
        side: BorderSide(color: type == TagItemType.filter ? color! : colors.surfaceVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onDeleted: type == TagItemType.add ? null : (){},
        deleteIcon: Icon(LineIcons.times, size: 0.25.dp,),
      ),
    );
  }
}