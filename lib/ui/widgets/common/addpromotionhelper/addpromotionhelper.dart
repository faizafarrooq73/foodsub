import 'package:flutter/material.dart';
import 'package:food_sub/ui/common/app_strings.dart';
import 'package:food_sub/ui/common/ui_helpers.dart';
import 'package:food_sub/ui/common/uihelper/button_helper.dart';
import 'package:food_sub/ui/common/uihelper/text_helper.dart';
import 'package:food_sub/ui/common/uihelper/text_veiw_helper.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import 'addpromotionhelper_model.dart';

class Addpromotionhelper extends StackedView<AddpromotionhelperModel> {
  const Addpromotionhelper({super.key});

  @override
  Widget builder(
    BuildContext context,
    AddpromotionhelperModel viewModel,
    Widget? child,
  ) {
    return Container(
        width: screenWidth(context),
        color: white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpaceSmall,
            text_helper(
                data: "Add Promotion",
                font: nunito,
                color: kcDarkGreyColor,
                size: fontSize18,
                bold: true),
            verticalSpaceTiny,
            viewModel.imageFile == null
                ? InkWell(
                    onTap: () => viewModel.pickImage(),
                    child: const Icon(Icons.browse_gallery_outlined,
                        color: kcPrimaryColor, size: 100),
                  )
                : InkWell(
                    onTap: () => viewModel.pickImage(),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            offset: const Offset(2, 2),
                            blurRadius: 1,
                            spreadRadius: 1,
                            color: getColorWithOpacity(kcDarkGreyColor, 0.2))
                      ], borderRadius: BorderRadius.circular(10), color: white),
                      child: Image.file(
                        viewModel.imageFile!,
                        fit: BoxFit.cover,
                        width: screenWidth(context),
                        height: screenWidthCustom(context, 0.5),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: text_view_helper(
                hint: "Enter Discount",
                controller: viewModel.dis,
                showicon: true,
                icon: const Icon(Icons.discount),
                textInputType: TextInputType.number,
              ),
            ),
            InkWell(
              onTap: () => viewModel.selectDate(context),
              child: Container(
                width: screenWidth(context),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: const Offset(2, 2),
                      blurRadius: 1,
                      spreadRadius: 1,
                      color: getColorWithOpacity(kcDarkGreyColor, 0.2))
                ], borderRadius: BorderRadius.circular(10), color: white),
                child: text_helper(
                    data: viewModel.date.text.isEmpty
                        ? "End Date"
                        : viewModel.date.text,
                    font: nunito,
                    color: kcDarkGreyColor,
                    size: fontSize14),
              ),
            ),
            button_helper(
                onpress: () => viewModel.add(context),
                color: kcPrimaryColor,
                width: screenWidth(context),
                child: text_helper(
                    data: "Add Promotion",
                    font: nunito,
                    color: kcDarkGreyColor,
                    bold: true,
                    size: fontSize14)),
            verticalSpaceSmall,
          ],
        ));
  }

  @override
  AddpromotionhelperModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddpromotionhelperModel();
}
