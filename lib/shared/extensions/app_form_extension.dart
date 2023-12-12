import 'package:flutter/material.dart';
import 'package:focus/main.dart';
import 'package:focus/shared/extensions/styles_extension.dart';
import 'package:focus/shared/widgets/app_form.dart';
import 'package:line_icons/line_icons.dart';

extension AppFormInputDecoration on AppFormType{
  InputDecoration inputDecoration({IconData? icon, required String hintText, double? vertical, TextEditingController? controller, ValueNotifier<String>? text, void Function(String)? onDelete, Color? borderColor}){
    final colors = navigatorKey.currentContext!.appColors;

    final decoration = InputDecoration(
      prefixIcon: icon == null ? null : Icon(icon, color: Colors.grey,),
      suffixIcon: clearButton(controller: controller, text: text, onDelete: onDelete),
      hintText: hintText,
    );

    switch(this){
      case AppFormType.outline || AppFormType.search || AppFormType.multiline:
        return decoration.copyWith(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: borderColor ?? colors.surfaceVariant.withOpacity(0.25)),
              borderRadius: BorderRadius.circular(12)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: colors.primary),
              borderRadius: BorderRadius.circular(12)
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: borderColor ?? colors.surfaceVariant.withOpacity(0.25)),
              borderRadius: BorderRadius.circular(12)
          ),
          contentPadding: vertical == null ? null : EdgeInsets.symmetric(vertical: vertical),
        );
      case AppFormType.underline:
        return decoration.copyWith(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colors.primary)
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colors.surfaceVariant)
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colors.surfaceVariant)
          ),
          fillColor: colors.background
        );
      case AppFormType.none:
        return decoration.copyWith(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          fillColor: Colors.transparent
        );
    }
  }

  Widget? clearButton({TextEditingController? controller, ValueNotifier<String>? text, void Function(String)? onDelete}) {
    if (controller != null && controller.text.isNotEmpty && text != null && text.value.isNotEmpty) {
      return GestureDetector(
        onTap: (){
          controller.clear();
          text.value = "";

          if(onDelete != null){
            onDelete("");
          }
        },
        child: const Icon(LineIcons.times, color: Colors.grey,),
      );
    }

    return null;
  }
}