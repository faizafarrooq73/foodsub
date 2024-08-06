import 'package:flutter/material.dart';
import 'package:food_sub/ui/common/app_colors.dart';
import 'package:food_sub/ui/common/app_strings.dart';
import 'package:food_sub/ui/common/uihelper/button_helper.dart';
import 'package:food_sub/ui/common/uihelper/text_helper.dart';
import 'package:food_sub/ui/common/uihelper/text_veiw_helper.dart';
import 'package:stacked/stacked.dart';

import '../../../common/apihelpers/apihelper.dart';
import '../../../common/ui_helpers.dart';
import '../../../common/uihelper/snakbar_helper.dart';
import 'additem_model.dart';

class Additem extends StackedView<AdditemModel> {
  const Additem({super.key});

  @override
  Widget builder(
    BuildContext context,
    AdditemModel viewModel,
    Widget? child,
  ) {
    return Container(
      width: screenWidth(context),
      height: screenHeightCustom(context, 0.7),
      padding: const EdgeInsets.all(10),
      color: white,
      child: Column(
        children: [
          Container(
            width: screenWidth(context),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: kcPrimaryColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/item.png',
                  width: screenWidthCustom(context, 0.05),
                  height: screenWidthCustom(context, 0.05),
                ),
                horizontalSpaceSmall,
                text_helper(
                    data: "Items",
                    font: openSans,
                    bold: true,
                    color: kcDarkGreyColor,
                    size: fontSize16),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: screenWidthCustom(context, 0.8),
                  child: text_view_helper(
                      hint: "Add Item",
                      showicon: true,
                      icon: const Icon(Icons.add),
                      controller: viewModel.item)),
              button_helper(
                  onpress: () => viewModel.additem(context),
                  color: kcDarkGreyColor,
                  width: screenWidthCustom(context, 0.1),
                  child: const Icon(
                    Icons.add,
                    color: white,
                    size: 30,
                  ))
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future:
                  ApiHelper.getitem(viewModel.sharedpref.readString('number')),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.toString() == '[]') {
                    return Center(
                      child: text_helper(
                          data: "No Item Added",
                          font: openSans,
                          color: kcDarkGreyColor,
                          size: fontSize12),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3.5,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              text_helper(
                                  data: snapshot.data[index]['name'],
                                  font: openSans,
                                  bold: true,
                                  color: kcDarkGreyColor,
                                  size: fontSize16),
                              InkWell(
                                  onTap: () => viewModel
                                      .delete(snapshot.data[index]['_id']),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        );
                      },
                      itemCount: snapshot.data.length,
                    );
                  }
                } else if (snapshot.hasError) {
                  return const Icon(
                    Icons.error,
                    color: kcDarkGreyColor,
                  );
                } else {
                  return displaysimpleprogress(context);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  AdditemModel viewModelBuilder(
    BuildContext context,
  ) =>
      AdditemModel();
}
