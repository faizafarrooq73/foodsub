import 'package:flutter/material.dart';
import 'package:food_sub/ui/common/app_strings.dart';
import 'package:food_sub/ui/common/uihelper/text_veiw_helper.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../common/uihelper/button_helper.dart';
import '../../../common/uihelper/text_helper.dart';
import 'cart_model.dart';

class Cart extends StackedView<CartModel> {
  Cart({super.key, required this.cart, required this.restnumber});
  List cart;
  String restnumber;

  @override
  Widget builder(
    BuildContext context,
    CartModel viewModel,
    Widget? child,
  ) {
    return Column(
      children: [
        Container(
          width: screenWidth(context),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: getColorWithOpacity(kcPrimaryColor, 0.2)),
          child: text_helper(
            data: "Confirm order",
            font: nunito,
            textAlign: TextAlign.start,
            color: kcDarkGreyColor,
            size: fontSize12,
            bold: true,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: viewModel.menus.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text_helper(
                            data: viewModel.menus[index]['itemname'],
                            font: nunito,
                            bold: true,
                            color: kcDarkGreyColor,
                            size: fontSize12,
                            textAlign: TextAlign.start,
                          ),
                          text_helper(
                            data: viewModel.menus[index]['itemprice'],
                            font: nunito,
                            bold: true,
                            color: kcPrimaryColor,
                            size: fontSize10,
                            textAlign: TextAlign.start,
                          ),
                          text_helper(
                            data: viewModel.menus[index]['itemdes'],
                            font: nunito,
                            bold: true,
                            color: kcLightGrey,
                            size: fontSize10,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            button_helper(
                                onpress: () => viewModel.plus(index),
                                color: kcPrimaryColor,
                                width: screenWidthCustom(context, 0.1),
                                child: const Icon(
                                  Icons.add,
                                  color: white,
                                )),
                            text_helper(
                              data: viewModel.menus[index]['quantity'],
                              font: nunito,
                              color: kcDarkGreyColor,
                              size: fontSize14,
                              bold: true,
                            ),
                            button_helper(
                                onpress: () => viewModel.minus(index),
                                color: kcPrimaryColor,
                                width: screenWidthCustom(context, 0.1),
                                child: const Icon(
                                  Icons.minimize,
                                  color: white,
                                ))
                          ],
                        ),
                        text_helper(
                          data: "Rs " + viewModel.menus[index]['editprice'],
                          font: nunito,
                          color: kcPrimaryColor,
                          size: fontSize12,
                          bold: true,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        InkWell(
          onTap: () => viewModel.book(context, restnumber),
          child: Container(
            width: screenWidth(context),
            height: 50,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: kcPrimaryColor, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                text_helper(
                    data: "Confirm Order",
                    font: nunito,
                    color: white,
                    bold: true,
                    size: fontSize14),
                horizontalSpaceSmall,
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: white),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: kcPrimaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: text_view_helper(hint: "Enter Discount code",
              showicon: true,
              icon: const Icon(Icons.discount),
              controller: viewModel.discount),
        ),
        Container(
          width: screenWidth(context),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kcVeryLightGrey,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                      value: viewModel.schedule,
                      onChanged: (value) {
                        viewModel.schedule = value!;
                        viewModel.notifyListeners();
                      }),
                  Expanded(
                    child: text_helper(
                      data: "Schedule this order for next few days",
                      font: nunito,
                      color: kcDarkGreyColor,
                      size: fontSize12,
                      bold: true,
                    ),
                  ),
                ],
              ),
              viewModel.schedule
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_helper(
                                data: "Number of Days",
                                font: nunito,
                                color: kcDarkGreyColor,
                                size: fontSize12),
                            DropdownButton<String>(
                              value: viewModel.days,
                              onChanged: (String? newValue) {
                                viewModel.days = newValue!;
                                viewModel.notifyListeners();
                              },
                              items: viewModel.dayss
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => viewModel.selectTime(context),
                          child: text_helper(
                              data: viewModel.time == ""
                                  ? "Select Time"
                                  : viewModel.time,
                              font: nunito,
                              color: kcDarkGreyColor,
                              size: fontSize12),
                        )
                      ],
                    )
                  : const SizedBox.shrink()
            ],
          ),
        )
      ],
    );
  }

  @override
  void onViewModelReady(CartModel viewModel) => viewModel.first(cart);

  @override
  CartModel viewModelBuilder(
    BuildContext context,
  ) =>
      CartModel();
}
