import 'package:flutter/material.dart';
import 'package:focus/shared/extensions/app_form_extension.dart';
import 'package:line_icons/line_icons.dart';

enum AppFormType { outline, underline, search, none, multiline }

//ignore: must_be_immutable
class AppForm extends StatefulWidget{
  AppForm.search({
    super.key,
    required this.hintText,
    this.icon = LineIcons.search,
    this.type = AppFormType.search,
    this.vertical,
    this.autoFocus,
    this.focus,
    this.controller,
    this.text,
    this.onChanged,
    this.onFieldSubmitted,
    this.onDelete,
    this.onTap,
  });

  AppForm.outline({
    super.key,
    required this.hintText,
    this.icon,
    this.type = AppFormType.outline,
    this.vertical,
    this.autoFocus,
    this.controller,
    this.borderColor,
    this.onTap,
    this.focus
  });

  AppForm.underline({
    super.key,
    required this.hintText,
    this.icon,
    this.type = AppFormType.underline,
    this.vertical,
    this.autoFocus,
    this.controller,
    this.onTap,
  });

  AppForm.none({
    super.key,
    required this.hintText,
    this.icon,
    this.type = AppFormType.none,
    this.vertical,
    this.autoFocus,
    this.controller,
    this.onTap,
  });

  AppForm.multiline({
    super.key,
    required this.hintText,
    this.icon,
    this.type = AppFormType.multiline,
    this.vertical,
    this.autoFocus,
    this.controller,
    this.maxLine = 5,
    this.keyboardType = TextInputType.multiline,
    this.borderColor,
    this.onTap,
  });

  final String hintText;
  final AppFormType type;
  IconData? icon;
  double? vertical;
  bool? autoFocus;
  FocusNode? focus;
  TextEditingController? controller;
  ValueNotifier<String>? text;
  void Function(String)? onChanged;
  void Function(String)? onFieldSubmitted;
  void Function(String)? onDelete;
  Color? borderColor;
  int? maxLine;
  TextInputType? keyboardType;
  void Function()? onTap;

  @override
  State<AppForm> createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  late ValueNotifier<String> _text;

  @override
  void initState() {
    _text = ValueNotifier<String>("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _text,
      builder: (context, value, _){
        return TextFormField(
          controller: widget.controller,
          decoration: widget.type.inputDecoration(
            icon: widget.icon,
            hintText: widget.hintText,
            vertical: widget.vertical,
            controller: widget.controller,
            text: _text,
            onDelete: widget.onDelete,
            borderColor: widget.borderColor
          ),
          onTap: widget.onTap,
          onChanged: widget.onChanged == null ? null : (value){
            if(widget.onChanged != null){
              widget.onChanged!(value);
            }

            _text.value = value;
          },
          onFieldSubmitted: widget.onFieldSubmitted == null ? null : (value){
            widget.onFieldSubmitted!(value);
          },
          autofocus: widget.autoFocus ?? false,
          focusNode: widget.focus,
          maxLines: widget.maxLine,
          keyboardType: widget.keyboardType,
        );
      },
    );
  }
}