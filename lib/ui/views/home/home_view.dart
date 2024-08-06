import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_sub/ui/common/app_strings.dart';
import 'package:food_sub/ui/common/commonhelper/showdetails.dart';
import 'package:stacked/stacked.dart';
import 'package:food_sub/ui/common/app_colors.dart';
import 'package:food_sub/ui/common/ui_helpers.dart';

import '../../common/apihelpers/apihelper.dart';
import '../../common/commonhelper/commonwidgets.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../../common/uihelper/text_helper.dart';
import '../../common/uihelper/text_veiw_helper.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: kcPrimaryColor,
          actions: [
            InkWell(
              onTap: () => showdetails(context, viewModel.sharedpref),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: viewModel.sharedpref.readString('img'),
                    imageBuilder: (context, imageProvider) => Container(
                      width: screenWidthCustom(context, 0.1),
                      height: screenWidthCustom(context, 0.1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: kcDarkGreyColor,
                    ),
                  ),
                ),
              ),
            )
          ],
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text_helper(
                  data: viewModel.sharedpref.readString('name'),
                  font: openSans,
                  color: kcDarkGreyColor,
                  bold: true,
                  size: fontSize14),
              text_helper(
                  data: viewModel.sharedpref.readString('number'),
                  font: openSans,
                  color: kcDarkGreyColor,
                  size: fontSize14),
            ],
          )),
      drawer: drawer(
        context,
        Column(
          children: [
            actions(context, viewModel.allchat, Icons.chat, 'All Chats'),
            actions(context, viewModel.order, Icons.border_color, 'Order'),
            actions(context, viewModel.login, Icons.logout, 'Logout'),
          ],
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: kcPrimaryColor,
              child: text_view_helper(
                  hint: "Search for shops & restaurants",
                  showicon: true,
                  onchange: (val) {
                    viewModel.notifyListeners();
                  },
                  icon: const Icon(
                    Icons.search_rounded,
                    size: 25,
                  ),
                  controller: viewModel.searchBar)),
          verticalSpaceSmall,
          viewModel.searchBar.text.isEmpty
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: ()=>viewModel.deal(),
                          child: dealPromo(context, "Deal", "Upto 70% off ",
                              "assets/deal.png"),
                        ),
                        InkWell(
                          onTap: ()=>viewModel.promotion(),
                          child: dealPromo(context, "Promotions", "Upto 70% off ",
                              "assets/promo.png"),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          text_helper(
                              data: "All Restaurants",
                              font: openSans,
                              color: kcDarkGreyColor,
                              size: fontSize14,
                              bold: true),
                          horizontalSpaceSmall,
                          Image.asset(
                            'assets/fire.png',
                            width: screenWidthCustom(context, 0.07),
                            height: screenHeightCustom(context, 0.07),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: FutureBuilder(
                        future: ApiHelper.getallrest(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data['rest'].length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return popularRestaurants(context,
                                      snapshot.data['rest'][index], viewModel);
                                });
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
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          text_helper(
                              data: "All Dishes",
                              font: openSans,
                              color: kcDarkGreyColor,
                              size: fontSize14,
                              bold: true),
                          horizontalSpaceSmall,
                          Image.asset(
                            'assets/fire.png',
                            width: screenWidthCustom(context, 0.07),
                            height: screenHeightCustom(context, 0.07),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          FutureBuilder(
            future: ApiHelper.allmenuwn(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                    children: List.of(snapshot.data['rest'])
                        .map((e) => viewModel.searchBar.text.isEmpty
                            ? listdata(context, e, viewModel)
                            : e['itemname'].toLowerCase().contains(
                                    viewModel.searchBar.text.toLowerCase())
                                ? listdata(context, e, viewModel)
                                : const SizedBox.shrink())
                        .toList());
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
        ],
      )),
    );
  }

  Widget listdata(BuildContext context, Map e, HomeViewModel viewModel) {
    return InkWell(
      onTap: () => viewModel.move(e['number']),
      child: Container(
        width: screenWidth(context),
        height: 140,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            Expanded(
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
                                bold: true,
                                color: kcDarkGreyColor,
                                size: fontSize8,
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
                        placeholder: (context, url) =>
                            displaysimpleprogress(context),
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
            verticalSpaceSmall,
            Container(
              width: screenWidth(context),
              height: 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: kcLightGrey),
            )
          ],
        ),
      ),
    );
  }

  Widget popularRestaurants(
      BuildContext context, Map data, HomeViewModel viewModel) {
    return InkWell(
      onTap: () => viewModel.move(data['number']),
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: screenWidthCustom(context, 0.7),
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: data['image'],
              imageBuilder: (context, imageProvider) => Container(
                width: screenWidthCustom(context, 1),
                height: screenWidthCustom(context, 0.38),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: kcDarkGreyColor,
              ),
            ),
            verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text_helper(
                    data: data['name'],
                    font: openSans,
                    color: kcDarkGreyColor,
                    size: fontSize14,
                    bold: true),
                Row(
                  children: [
                    text_helper(
                        data:
                            "${double.parse(data['rating']) / double.parse(data['user'])}",
                        font: openSans,
                        color: kcDarkGreyColor,
                        size: fontSize12,
                        bold: true),
                    horizontalSpaceTiny,
                    text_helper(
                        data: data['review'].length.toString(),
                        font: openSans,
                        color: kcLightGrey,
                        size: fontSize12,
                        bold: false),
                  ],
                )
              ],
            ),
            text_helper(
                data: data['open'] + " - " + data['close'],
                font: openSans,
                color: kcLightGrey,
                size: fontSize14,
                bold: false),
            Row(
              children: [
                text_helper(
                    data: "30 min",
                    font: openSans,
                    color: kcLightGrey,
                    size: fontSize12,
                    bold: false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dealPromo(BuildContext context, String deal, String des, String img) {
    return Container(
      height: screenHeight(context) * 0.12,
      width: screenWidthCustom(context, 0.4),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: getColorWithOpacity(kcLightGrey, 0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                text_helper(
                    data: deal,
                    font: openSans,
                    color: kcDarkGreyColor,
                    size: fontSize14,
                    bold: true),
                text_helper(
                    data: des,
                    font: openSans,
                    color: kcDarkGreyColor,
                    size: fontSize12,
                    bold: false),
              ],
            ),
          ),
          Image.asset(img,
              width: screenWidth(context) * 0.09,
              height: screenWidth(context) * 0.09),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
