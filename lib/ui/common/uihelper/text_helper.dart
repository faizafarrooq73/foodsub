// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_strings.dart';
import '../ui_helpers.dart';

class text_helper extends StatelessWidget {
  text_helper(
      {super.key,
      required this.data,
      required this.font,
      required this.color,
      required this.size,
      this.maxlines,
      this.bold = false,
      this.textAlign = TextAlign.center});

  String data, font;
  Color color;
  double? size;
  bool bold;
  TextAlign textAlign;
  int? maxlines;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: customstyle(font, color, size, context, bold),
      textAlign: textAlign,
      maxLines: maxlines,
    );
  }

  static TextStyle customstyle(
      String font, Color color, double? size, BuildContext context, bool bold) {
    if (font == nunito) {
      return GoogleFonts.nunito(
          color: color,
          fontSize: getResponsiveFontSize(context, fontSize: size) * 3,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal);
    } else if (font == openSans) {
      return GoogleFonts.openSans(
          color: color,
          fontSize: getResponsiveFontSize(context, fontSize: size) * 3,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal);
    } else {
      return GoogleFonts.birthstone(
          color: color,
          fontSize: getResponsiveFontSize(context, fontSize: size) * 3,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal);
    }
  }
}
