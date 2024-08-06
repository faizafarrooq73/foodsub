import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../common/apihelpers/apihelper.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_strings.dart';
import '../../../../common/ui_helpers.dart';
import '../../../../common/uihelper/snakbar_helper.dart';
import '../../../../common/uihelper/text_helper.dart';
import 'showpromotions_viewmodel.dart';

class ShowpromotionsView extends StackedView<ShowpromotionsViewModel> {
  const ShowpromotionsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ShowpromotionsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: text_helper(
            data: "All Promotion",
            font: nunito,
            color: kcDarkGreyColor,
            size: fontSize14,
            bold: true,
          ),
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: ApiHelper.allpromotion(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.toString() == '[]') {
                  return Center(
                    child: text_helper(
                        data: "No Data",
                        font: nunito,
                        color: kcDarkGreyColor,
                        size: fontSize14),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      DateTime parsedDate =
                          DateTime.parse(snapshot.data[index]['date']);
                      DateTime currentDate = DateTime.now();
                      int comparison = currentDate.compareTo(parsedDate);
                      if (comparison > 0) {
                        return listdata(context, snapshot, index, viewModel);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
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
        ));
  }

  Widget listdata(BuildContext context, AsyncSnapshot snapshot, int index,
      ShowpromotionsViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: snapshot.data[index]['img'],
            imageBuilder: (context, imageProvider) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: screenWidthCustom(context, 0.25),
                height: screenWidthCustom(context, 0.25),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            placeholder: (context, url) => displaysimpleprogress(context),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: kcDarkGreyColor,
            ),
          ),
          horizontalSpaceSmall,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text_helper(
                    data: "Discount : " + snapshot.data[index]['dis'],
                    font: nunito,
                    bold: true,
                    color: kcDarkGreyColor,
                    size: fontSize14),
                text_helper(
                    data: snapshot.data[index]['date'],
                    font: nunito,
                    color: kcDarkGreyColor,
                    size: fontSize12),
                text_helper(
                    data: "Code : " + snapshot.data[index]['code'],
                    font: nunito,
                    color: kcDarkGreyColor,
                    size: fontSize12),
              ],
            ),
          ),
          horizontalSpaceSmall,
          InkWell(
              onTap: () =>
                  viewModel.copy(context, snapshot.data[index]['code']),
              child: const Icon(
                Icons.copy,
                color: Colors.green,
              )),
          horizontalSpaceSmall,
        ],
      ),
    );
  }

  @override
  ShowpromotionsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ShowpromotionsViewModel();
}
