import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_sub/ui/common/app_strings.dart';
import 'package:food_sub/ui/common/ui_helpers.dart';
import 'package:food_sub/ui/common/uihelper/text_helper.dart';
import 'package:food_sub/ui/widgets/common/additem/additem.dart';
import 'package:food_sub/ui/widgets/common/addmenu/addmenu.dart';
import 'package:stacked/stacked.dart';

import '../../common/apihelpers/apihelper.dart';
import '../../common/app_colors.dart';
import '../../common/uihelper/snakbar_helper.dart';
import 'provider_viewmodel.dart';

class ProviderView extends StackedView<ProviderViewModel> {
  const ProviderView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProviderViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: text_helper(
              data: "Admin",
              font: openSans,
              bold: true,
              color: kcDarkGreyColor,
              size: fontSize16),
          actions: [
            InkWell(
              onTap: () {
                viewModel.notifyListeners();
              },
              child: const Padding(
                  padding: EdgeInsets.all(8.0), child: Icon(Icons.refresh)),
            ),
            InkWell(
              onTap: () => edit(context, viewModel),
              child: const Padding(
                  padding: EdgeInsets.all(8.0), child: Icon(Icons.edit)),
            ),
            InkWell(
              onTap: () => menu(context, {}),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/menu.png',
                  width: screenWidthCustom(context, 0.05),
                  height: screenWidthCustom(context, 0.05),
                ),
              ),
            ),
            InkWell(
              onTap: () => item(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/item.png',
                  width: screenWidthCustom(context, 0.05),
                  height: screenWidthCustom(context, 0.05),
                ),
              ),
            ),
          ],
        ),
        drawer: drawer(context, viewModel),
        body: SafeArea(
            child: FutureBuilder(
          future:
              ApiHelper.allmenuadmin(viewModel.sharedpref.readString('number')),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data['rest'].length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => menu(context, snapshot.data['rest'][index]),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            text_helper(
                                                data: snapshot.data['rest']
                                                    [index]['cat'],
                                                font: openSans,
                                                bold: true,
                                                color: kcPrimaryColor,
                                                size: fontSize12),
                                            text_helper(
                                                data: snapshot.data['rest']
                                                    [index]['itemname'],
                                                bold: true,
                                                font: openSans,
                                                color: kcDarkGreyColor,
                                                size: fontSize14),
                                            text_helper(
                                              data: snapshot.data['rest'][index]
                                                  ['itemdes'],
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
                                          data: 'starting from ' +
                                              snapshot.data['rest'][index]
                                                  ['itemprice'],
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
                                      imageUrl: snapshot.data['rest'][index]
                                          ['image'],
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          displaysimpleprogress(context),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
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
                                borderRadius: BorderRadius.circular(10),
                                color: kcLightGrey),
                          )
                        ],
                      ),
                    ),
                  );
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
        )));
  }

  void menu(BuildContext context, Map data) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Addmenu(
            data: data,
          );
        });
  }

  void item(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const Additem();
        });
  }

  void edit(BuildContext context, ProviderViewModel viewModel) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
              color: white,
              width: screenWidth(context),
              height: screenHeightCustom(context, 0.7),
              child: FutureBuilder(
                future: ApiHelper.getrest(
                    viewModel.sharedpref.readString('number')),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: snapshot.data['rest'][0]['image'],
                          imageBuilder: (context, imageProvider) => Container(
                            width: screenWidthCustom(context, 1),
                            height: screenWidthCustom(context, 0.7),
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
              ));
        });
  }

  Drawer drawer(BuildContext context, ProviderViewModel viewModel) {
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
          Expanded(
            child: Column(
              children: [
                actions(context, viewModel.allchat, Icons.chat, 'All Chats'),
                actions(context, viewModel.addpromotion,
                    Icons.production_quantity_limits_outlined, 'Add Promotion'),
                actions(context, viewModel.order, Icons.border_color, 'Order'),
                actions(context, viewModel.login, Icons.logout, 'Logout'),
              ],
            ),
          )
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

  @override
  ProviderViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProviderViewModel();
}
