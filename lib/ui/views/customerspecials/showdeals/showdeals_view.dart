import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/apihelpers/apihelper.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_strings.dart';
import '../../../common/ui_helpers.dart';
import '../../../common/uihelper/snakbar_helper.dart';
import '../../../common/uihelper/text_helper.dart';
import 'showdeals_viewmodel.dart';

class ShowdealsView extends StackedView<ShowdealsViewModel> {
  const ShowdealsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ShowdealsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: kcPrimaryColor,
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
            future: ApiHelper.allmenuwn(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                    children: List.of(snapshot.data['rest'])
                        .map((e) => e['type'] == "deal"
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
        ));
  }

  Widget listdata(BuildContext context, Map e, ShowdealsViewModel viewModel) {
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

  @override
  ShowdealsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ShowdealsViewModel();
}
