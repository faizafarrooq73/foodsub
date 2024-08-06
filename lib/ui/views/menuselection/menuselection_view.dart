import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_sub/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import '../../common/apihelpers/apihelper.dart';
import '../../common/app_strings.dart';
import '../../common/ui_helpers.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../../common/uihelper/text_helper.dart';
import 'menuselection_viewmodel.dart';

class MenuselectionView extends StackedView<MenuselectionViewModel> {
  MenuselectionView({Key? key, required this.number}) : super(key: key);
  String number;

  @override
  Widget builder(
    BuildContext context,
    MenuselectionViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: Column(
        children: [
          FutureBuilder(
            future: ApiHelper.getrest(number),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              snapshot.data['rest'][0]['image'].toString(),
                          imageBuilder: (context, imageProvider) => Container(
                            width: screenWidthCustom(context, 1),
                            height: screenWidthCustom(context, 0.5),
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
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () => viewModel.back(),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: white),
                                    child: const Icon(Icons.arrow_back),
                                  ),
                                ),
                                horizontalSpaceSmall,
                                text_helper(
                                    data: snapshot.data['rest'][0]['name'],
                                    font: birthstone,
                                    bold: true,
                                    color: kcDarkGreyColor,
                                    size: fontSize30)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: screenWidth(context),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: getColorWithOpacity(kcLightGrey, 0.1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.timelapse_outlined),
                              horizontalSpaceSmall,
                              text_helper(
                                  data: "Opening hours",
                                  font: openSans,
                                  bold: true,
                                  color: kcDarkGreyColor,
                                  size: fontSize14),
                            ],
                          ),
                          text_helper(
                              data: "Monday - Sunday",
                              font: openSans,
                              color: kcLightGrey,
                              size: fontSize12),
                          text_helper(
                              data: snapshot.data['rest'][0]['open'] +
                                  " - " +
                                  snapshot.data['rest'][0]['close'],
                              font: openSans,
                              color: kcLightGrey,
                              size: fontSize12)
                        ],
                      ),
                    )
                  ],
                );
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
          FutureBuilder(
            future: ApiHelper.getitem(number),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.toString() == '[]') {
                  return const SizedBox.shrink();
                } else {
                  viewModel.itemf(snapshot.data[0]['name']);
                  return SizedBox(
                    width: screenWidth(context),
                    height: 35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () =>
                              viewModel.item(snapshot.data[index]['name']),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                              children: [
                                text_helper(
                                    data: snapshot.data[index]['name'],
                                    font: openSans,
                                    bold: viewModel.s ==
                                            snapshot.data[index]['name']
                                        ? true
                                        : false,
                                    color: viewModel.s ==
                                            snapshot.data[index]['name']
                                        ? Colors.red
                                        : kcDarkGreyColor,
                                    size: fontSize14),
                                verticalSpaceTiny,
                                viewModel.s == snapshot.data[index]['name']
                                    ? Container(
                                        width: 30,
                                        height: 2,
                                        color: viewModel.s ==
                                                snapshot.data[index]['name']
                                            ? Colors.red
                                            : kcDarkGreyColor,
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                          ),
                        );
                      },
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
          verticalSpaceTiny,
          Expanded(
            child: FutureBuilder(
              future: ApiHelper.getallmenu(number, viewModel.s),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data['rest'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return listdata(
                          context, snapshot.data['rest'][index], viewModel);
                    },
                  );
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
          ),
        ],
      )),
      bottomNavigationBar: viewModel.cart.isEmpty
          ? const SizedBox.shrink()
          : InkWell(
              onTap: () => viewModel.order(context, number),
              child: Container(
                width: screenWidth(context),
                height: 50,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: kcPrimaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 1, color: white)),
                      child: Center(
                        child: text_helper(
                            data: viewModel.cart.length.toString(),
                            font: nunito,
                            color: white,
                            size: fontSize12),
                      ),
                    ),
                    text_helper(
                        data: "View your Cart",
                        font: nunito,
                        color: white,
                        bold: true,
                        size: fontSize14),
                    text_helper(
                        data: "Rs ${viewModel.price}",
                        font: nunito,
                        color: white,
                        bold: true,
                        size: fontSize14),
                  ],
                ),
              ),
            ),
    );
  }

  Widget listdata(
      BuildContext context, Map e, MenuselectionViewModel viewModel) {
    return InkWell(
      onTap: () => viewModel.cartt(e),
      child: Container(
        width: screenWidth(context),
        height: 120,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text_helper(
                            data: e['cat'],
                            font: openSans,
                            bold: true,
                            color: kcPrimaryColor,
                            size: fontSize12),
                        text_helper(
                            data: e['itemname'],
                            bold: true,
                            font: openSans,
                            color: kcDarkGreyColor,
                            size: fontSize14),
                        text_helper(
                          data: e['itemdes'],
                          textAlign: TextAlign.start,
                          font: openSans,
                          maxlines: 2,
                          color: kcDarkGreyColor,
                          size: fontSize10,
                        ),
                      ],
                    ),
                  ),
                  text_helper(
                      data: 'starting from ' + e['itemprice'],
                      font: openSans,
                      color: kcDarkGreyColor,
                      size: fontSize12),
                ],
              ),
            ),
            SizedBox(
              width: screenWidthCustom(context, 0.4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: e['image'],
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => displaysimpleprogress(context),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: kcDarkGreyColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(MenuselectionViewModel viewModel) => viewModel.first();

  @override
  MenuselectionViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MenuselectionViewModel();
}
