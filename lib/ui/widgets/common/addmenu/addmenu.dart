import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_sub/ui/common/app_colors.dart';
import 'package:food_sub/ui/common/uihelper/button_helper.dart';
import 'package:stacked/stacked.dart';

import '../../../common/apihelpers/apihelper.dart';
import '../../../common/app_strings.dart';
import '../../../common/ui_helpers.dart';
import '../../../common/uihelper/snakbar_helper.dart';
import '../../../common/uihelper/text_helper.dart';
import '../../../common/uihelper/text_veiw_helper.dart';
import 'addmenu_model.dart';

class Addmenu extends StackedView<AddmenuModel> {
  Addmenu({super.key, required this.data});
  Map data;

  @override
  Widget builder(
    BuildContext context,
    AddmenuModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Container(
        width: screenWidth(context),
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        color: white,
        child: ListView(
          children: [
            Container(
              width: screenWidth(context),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kcPrimaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/menu.png',
                    width: screenWidthCustom(context, 0.05),
                    height: screenWidthCustom(context, 0.05),
                  ),
                  horizontalSpaceSmall,
                  text_helper(
                      data: "Menu",
                      font: openSans,
                      bold: true,
                      color: kcDarkGreyColor,
                      size: fontSize16),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button_helper(
                    onpress: () {
                      viewModel.type = "deal";
                      viewModel.notifyListeners();
                    },
                    color: viewModel.type == "menu"
                        ? kcPrimaryColor
                        : kcDarkGreyColor,
                    width: screenWidthCustom(context, 0.3),
                    child: text_helper(
                        data: "Menu",
                        font: nunito,
                        color: white,
                        size: fontSize14,
                        bold: true)),
                button_helper(
                    onpress: () {
                      viewModel.type = "menu";
                      viewModel.notifyListeners();
                    },
                    color: viewModel.type == "deal"
                        ? kcPrimaryColor
                        : kcDarkGreyColor,
                    width: screenWidthCustom(context, 0.3),
                    child: text_helper(
                        data: "Deal",
                        font: nunito,
                        color: white,
                        size: fontSize14,
                        bold: true)),
              ],
            ),
            FutureBuilder(
              future:
                  ApiHelper.getitem(viewModel.sharedpref.readString('number')),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  viewModel.additems(snapshot.data);
                  if (snapshot.data.toString() == '[]') {
                    return Center(
                      child: text_helper(
                          data: "No Item Added",
                          font: openSans,
                          color: kcDarkGreyColor,
                          size: fontSize12),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(2, 2),
                                blurRadius: 1,
                                spreadRadius: 1,
                                color:
                                    getColorWithOpacity(kcDarkGreyColor, 0.2))
                          ]),
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          text_helper(
                              data: "select Item",
                              font: openSans,
                              color: kcDarkGreyColor,
                              size: fontSize14),
                          DropdownButton<String>(
                            value: viewModel.selected,
                            icon: const Icon(Icons.arrow_downward),
                            onChanged: (String? newValue) {
                              viewModel.selected = newValue!;
                              viewModel.notifyListeners();
                            },
                            items: viewModel.item
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: text_helper(
                                    data: value,
                                    font: openSans,
                                    color: kcDarkGreyColor,
                                    size: fontSize14),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
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
            text_view_helper(
              hint: "Enter item name",
              controller: viewModel.name,
              showicon: true,
              icon: const Icon(Icons.table_bar_outlined),
            ).animate(delay: 500.milliseconds).fade().moveY(begin: 50, end: 0),
            text_view_helper(
              hint: "Enter item price",
              controller: viewModel.price,
              showicon: true,
              formatter: [FilteringTextInputFormatter.allow(getRegExpint())],
              icon: const Icon(Icons.table_bar_outlined),
            ).animate(delay: 700.milliseconds).fade().moveY(begin: 50, end: 0),
            text_view_helper(
              hint: "Enter item des",
              controller: viewModel.des,
              showicon: true,
              maxline: null,
              icon: const Icon(Icons.table_bar_outlined),
            ).animate(delay: 900.milliseconds).fade().moveY(begin: 50, end: 0),
            InkWell(
              onTap: () => viewModel.pic(),
              child: Container(
                width: screenWidth(context),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(2, 2),
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: getColorWithOpacity(kcDarkGreyColor, 0.2))
                    ]),
                child: Row(
                  children: [
                    viewModel.image == null
                        ? const Icon(
                            Icons.add_a_photo,
                            size: 50,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              viewModel.image!,
                              fit: BoxFit.cover,
                              width: screenWidthCustom(context, 0.12),
                              height: screenWidthCustom(context, 0.12),
                            ),
                          ),
                    horizontalSpaceSmall,
                    viewModel.imagep == ''
                        ? const SizedBox.shrink()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: viewModel.imagep,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: screenWidthCustom(context, 0.12),
                                height: screenWidthCustom(context, 0.12),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  displaysimpleprogress(context),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: kcDarkGreyColor,
                              ),
                            ),
                          ),
                    horizontalSpaceSmall,
                    text_helper(
                      data: viewModel.updatev ? "Change pic" : "Add Pic",
                      font: openSans,
                      color: kcDarkGreyColor,
                      size: fontSize14,
                    )
                  ],
                ),
              ),
            ).animate(delay: 1100.milliseconds).fade().moveY(begin: 50, end: 0),
            viewModel.updatev
                ? Row(
                    children: [
                      button_helper(
                              onpress: () => viewModel.updateactual(context),
                              color: kcDarkGreyColor,
                              width: screenWidthCustom(context, 0.4),
                              child: text_helper(
                                  data: "Update",
                                  font: openSans,
                                  bold: true,
                                  color: white,
                                  size: fontSize12))
                          .animate(delay: 1300.milliseconds)
                          .fade()
                          .moveY(begin: 50, end: 0),
                      button_helper(
                              onpress: () => viewModel.delete(context),
                              color: Colors.red,
                              width: screenWidthCustom(context, 0.4),
                              child: text_helper(
                                  data: "Delete",
                                  font: openSans,
                                  bold: true,
                                  color: white,
                                  size: fontSize12))
                          .animate(delay: 1300.milliseconds)
                          .fade()
                          .moveY(begin: 50, end: 0),
                    ],
                  )
                : button_helper(
                        onpress: () => viewModel.add(context),
                        color: kcDarkGreyColor,
                        width: screenWidth(context),
                        child: text_helper(
                            data: "Add Menu Item",
                            font: openSans,
                            bold: true,
                            color: white,
                            size: fontSize12))
                    .animate(delay: 1300.milliseconds)
                    .fade()
                    .moveY(begin: 50, end: 0),
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(AddmenuModel viewModel) => viewModel.update(data);

  @override
  AddmenuModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddmenuModel();
}
