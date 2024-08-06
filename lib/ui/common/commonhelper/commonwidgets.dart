import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../app_colors.dart';
import '../app_strings.dart';
import '../ui_helpers.dart';
import '../uihelper/text_helper.dart';

Drawer drawer(BuildContext context, Widget child) {
  return Drawer(
    backgroundColor: white,
    child: Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              text_helper(
                      data: "Food Sub",
                      font: birthstone,
                      bold: true,
                      color: kcDarkGreyColor,
                      size: fontSize30 + 20)
                  .animate(delay: 500.milliseconds)
                  .fade()
                  .moveY(begin: 50, end: 0),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
                child: text_helper(
                        data:
                            'This is the place where you can find the best food with best delivery time',
                        font: openSans,
                        color: kcDarkGreyColor,
                        size: fontSize12)
                    .animate(delay: 700.milliseconds)
                    .fade()
                    .moveY(begin: 50, end: 0),
              )
            ],
          ),
        ),
        Expanded(child: child)
      ],
    ),
  );
}

Widget actions(BuildContext context, void Function() function,
    IconData iconData, String txt) {
  return InkWell(
      onTap: () => function(),
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: kcPrimaryColor),
        child: Row(
          children: [
            Icon(
              iconData,
              color: kcDarkGreyColor,
            ),
            horizontalSpaceSmall,
            text_helper(
              data: txt,
              font: openSans,
              color: kcDarkGreyColor,
              size: fontSize14,
              bold: true,
            )
          ],
        ),
      )).animate(delay: 900.milliseconds).fade().moveY(begin: 50, end: 0);
}
