import 'package:flutter/material.dart';

const Color kcPrimaryColor = Color(0xFFffbc0c);
const Color kcPrimaryColorDark = Color(0xff339CE8);
const Color kcDarkGreyColor = Color(0xFF1A1B1E);
const Color kcMediumGrey = Color(0xFF474A54);
const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);
const Color kcVeryLightGrey = Color(0xFFE3E3E3);
const Color kcBackgroundColor = kcDarkGreyColor;
const Color white = Color(0xfff6f6f8);

Color getColorWithOpacity(Color colors, double val) {
  return colors.withOpacity(val);
}
