import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:focus/shared/extensions/string_extension.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/app_button.dart';
import 'package:focus/shared/widgets/app_form.dart';
import 'package:focus/shared/widgets/custom_app_bar.dart';
import 'package:focus/themes/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum AddPageType { tag, project }

class AddPage extends StatefulWidget{
  const AddPage.tag({
    super.key,
    this.type = AddPageType.tag,
  });

  const AddPage.project({
    super.key,
    this.type = AddPageType.project
  });

  final AddPageType type;

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final ValueNotifier<Color> _pickerColor = ValueNotifier<Color>(const Color(0xffff5722));

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.back(
        titleText: "Add New ${widget.type.name.toCapitalize}",
        titleStyle: AppTypography.heading4.copyWith(color: Colors.white),
        bgColor: colors.background,
        icon: LineIcons.times,
      ),
      body: _addBody(context),
    );
  }

  Widget _addBody(BuildContext context){
    final colors = context.appColors;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${widget.type.name.toCapitalize} Name",
                          style: AppTypography.labelButton1,
                        ),
                      ),
                      Gap(1.5.h),
                      AppForm.outline(hintText: "${widget.type.name.toCapitalize} Name", icon: widget.type == AddPageType.project ? LineIcons.briefcase : LineIcons.tag)
                    ],
                  ),
                  Gap(2.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${widget.type.name.toCapitalize} Color Mark",
                          style: AppTypography.labelButton1,
                        ),
                      ),
                      Gap(1.5.h),
                      SizedBox(
                        width: double.infinity,
                        height: 60.h,
                        child: ValueListenableBuilder(
                          valueListenable: _pickerColor,
                          builder: (context, value, _){
                            return BlockPicker(
                              useInShowDialog: false,
                              pickerColor: value,
                              onColorChanged: (color) => _pickerColor.value = color,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppButton(
                    onTap: () => Navigator.pop(context),
                    text: "Cancel",
                    backgroundColor: colors.onSecondary,
                    textColor: colors.onSecondaryContainer,
                  ),
                ),
                Gap(4.w),
                Expanded(
                  child: AppButton(
                      onTap: () => Navigator.pop(context),
                      text: "Add"
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}