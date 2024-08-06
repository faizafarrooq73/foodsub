// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_sub/ui/common/uihelper/text_helper.dart';

import '../app_colors.dart';
import '../app_strings.dart';
import '../ui_helpers.dart';

class text_view_helper extends StatelessWidget {
  text_view_helper(
      {super.key,
      required this.hint,
      required this.controller,
      this.textstyle = nunito,
      this.background = white,
      this.hintcol = kcMediumGrey,
      this.textcolor = kcDarkGreyColor,
      this.size = fontSize14,
      this.bold = false,
      this.obsecure = false,
      this.textInputType = TextInputType.text,
      this.maxline = 1,
      this.maxlength = 10000,
      this.width = 0.8,
      this.padding = const EdgeInsetsDirectional.all(0),
      this.margin = const EdgeInsetsDirectional.all(5),
      this.icon = const Icon(Icons.person),
      this.showicon = false,
      this.onchange,
      this.readonly = false,
      this.formatter = const [],
      this.inputBorder});
  String hint, textstyle;
  Color background, hintcol, textcolor;
  double size, width;
  bool bold, obsecure, showicon, readonly;
  int? maxline;
  int maxlength;
  TextInputType textInputType;
  TextEditingController controller;
  EdgeInsetsDirectional padding, margin;
  Icon icon;
  final Function(String)? onchange;
  InputBorder? inputBorder;
  List<TextInputFormatter> formatter;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenHeightCustom(context, width),
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(2, 2),
              blurRadius: 1,
              spreadRadius: 1,
              color: getColorWithOpacity(kcDarkGreyColor, 0.2))
        ], borderRadius: BorderRadius.circular(10), color: background),
        child: TextFormField(
          controller: controller,
          keyboardType: textInputType,
          readOnly: readonly,
          decoration: InputDecoration(
            border: inputBorder,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            counterText: "",
            hintStyle: text_helper.customstyle(
                textstyle, hintcol, size, context, bold),
            hintText: hint,
            prefixIcon: showicon ? icon : const SizedBox.shrink(),
          ),
          inputFormatters: formatter,
          obscureText: obsecure,
          maxLines: maxline,
          maxLength: maxlength,
          onChanged: onchange != null ? (value) => onchange!(value) : null,
          style: text_helper.customstyle(
              textstyle, textcolor, size, context, bold),
        ));
  }
}
