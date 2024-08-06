import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_sub/ui/common/app_colors.dart';
import 'package:food_sub/ui/common/ui_helpers.dart';
import 'package:food_sub/ui/common/uihelper/button_helper.dart';
import 'package:food_sub/ui/common/uihelper/text_helper.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_strings.dart';
import '../../common/uihelper/text_veiw_helper.dart';
import 'riderprovider_viewmodel.dart';

class RiderproviderView extends StackedView<RiderproviderViewModel> {
  const RiderproviderView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RiderproviderViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                text_helper(
                    data: "Welcome ! " + viewModel.sharedpref.readString('cat'),
                    bold: true,
                    font: birthstone,
                    color: kcDarkGreyColor,
                    size: fontSize30),
                InkWell(
                  onTap: () => viewModel.pic(),
                  child: Container(
                    width: screenWidthCustom(context, 0.93),
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: const Offset(2, 2),
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: getColorWithOpacity(kcDarkGreyColor, 0.2))
                    ], borderRadius: BorderRadius.circular(10), color: white),
                    child: viewModel.image == null
                        ? Row(
                            children: [
                              const Icon(Icons.picture_in_picture),
                              horizontalSpaceSmall,
                              text_helper(
                                  data: "Add Pic",
                                  font: openSans,
                                  color: kcDarkGreyColor,
                                  size: fontSize12),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              viewModel.image!,
                              width: screenWidth(context),
                              height: screenWidth(context),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                )
                    .animate(delay: 300.milliseconds)
                    .fade()
                    .moveY(begin: 50, end: 0),
                text_view_helper(
                  hint: "Enter Resturant name",
                  controller: viewModel.restname,
                  showicon: true,
                  icon: const Icon(Icons.drive_file_rename_outline),
                  formatter: [
                    FilteringTextInputFormatter.allow(getRegExpstring())
                  ],
                )
                    .animate(delay: 500.milliseconds)
                    .fade()
                    .moveY(begin: 50, end: 0),
                InkWell(
                  onTap: () => viewModel.selectTime(context, true),
                  child: Container(
                    width: screenWidthCustom(context, 0.93),
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: const Offset(2, 2),
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: getColorWithOpacity(kcDarkGreyColor, 0.2))
                    ], borderRadius: BorderRadius.circular(10), color: white),
                    child: Row(
                      children: [
                        const Icon(Icons.timelapse_outlined),
                        horizontalSpaceSmall,
                        text_helper(
                            data: viewModel.opening.text.isEmpty
                                ? "Select Opening Time"
                                : viewModel.opening.text,
                            font: openSans,
                            color: kcDarkGreyColor,
                            size: fontSize12),
                      ],
                    ),
                  ),
                )
                    .animate(delay: 700.milliseconds)
                    .fade()
                    .moveY(begin: 50, end: 0),
                verticalSpaceTiny,
                InkWell(
                  onTap: () => viewModel.selectTime(context, false),
                  child: Container(
                    width: screenWidthCustom(context, 0.93),
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: const Offset(2, 2),
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: getColorWithOpacity(kcDarkGreyColor, 0.2))
                    ], borderRadius: BorderRadius.circular(10), color: white),
                    child: Row(
                      children: [
                        const Icon(Icons.timelapse_outlined),
                        horizontalSpaceSmall,
                        text_helper(
                            data: viewModel.closing.text.isEmpty
                                ? "Select Closing Time"
                                : viewModel.closing.text,
                            font: openSans,
                            color: kcDarkGreyColor,
                            size: fontSize12),
                      ],
                    ),
                  ),
                )
                    .animate(delay: 900.milliseconds)
                    .fade()
                    .moveY(begin: 50, end: 0),
                button_helper(
                        onpress: () => viewModel.registerrest(context),
                        color: kcDarkGreyColor,
                        width: screenWidthCustom(context, 0.4),
                        child: text_helper(
                          data: "Continue",
                          font: openSans,
                          color: white,
                          size: fontSize14,
                          bold: true,
                        ))
                    .animate(delay: 1100.milliseconds)
                    .fade()
                    .moveY(begin: 50, end: 0),
              ],
            ),
          ),
        ));
  }

  @override
  RiderproviderViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RiderproviderViewModel();
}
