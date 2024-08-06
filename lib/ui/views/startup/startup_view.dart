import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_sub/ui/common/app_colors.dart';
import 'package:food_sub/ui/common/app_strings.dart';
import 'package:food_sub/ui/common/uihelper/text_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:food_sub/ui/common/ui_helpers.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
            child: Image.asset(
              'assets/top.jpg',
              width: screenWidth(context),
              height: screenHeightCustom(context, 0.6),
              fit: BoxFit.cover,
            ),
          ),
          verticalSpaceMedium,
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
          ),
          Container(
            width: screenWidthCustom(context, 0.4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: kcPrimaryColor),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: text_helper(
                data: "Let's Get Started !!",
                font: birthstone,
                color: kcDarkGreyColor,
                size: fontSize18),
          ).animate(delay: 900.milliseconds).fade().moveY(begin: 50, end: 0),
        ],
      ),
    ));
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
