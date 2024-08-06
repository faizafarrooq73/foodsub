import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_sub/ui/common/app_colors.dart';
import 'package:food_sub/ui/common/app_strings.dart';
import 'package:food_sub/ui/common/ui_helpers.dart';
import 'package:food_sub/ui/common/uihelper/text_helper.dart';
import 'package:food_sub/ui/views/booknow/booknow_view.dart';
import 'package:stacked/stacked.dart';

import '../../common/commonhelper/commonwidgets.dart';
import '../../common/commonhelper/showdetails.dart';
import 'rider_viewmodel.dart';

class RiderView extends StackedView<RiderViewModel> {
  const RiderView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RiderViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text_helper(
                data: "Welcome",
                font: nunito,
                color: kcDarkGreyColor,
                size: fontSize16,
                bold: true,
              ),
              text_helper(
                  data: "Rider",
                  font: nunito,
                  color: kcDarkGreyColor,
                  size: fontSize14),
            ],
          ),
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
        ),
        drawer: drawer(
          context,
          Column(
            children: [
              actions(context, viewModel.allchat, Icons.chat, 'All Chats'),
              actions(context, viewModel.login, Icons.logout, 'Logout'),
            ],
          ),
        ),
        body: SafeArea(
            child: BooknowView(
          acess: 'rider',
          appbarshow: false,
        )));
  }

  @override
  RiderViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RiderViewModel();
}
