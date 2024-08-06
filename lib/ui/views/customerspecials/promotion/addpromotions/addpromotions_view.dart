import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_sub/ui/common/apihelpers/apihelper.dart';
import 'package:food_sub/ui/common/app_colors.dart';
import 'package:food_sub/ui/common/app_strings.dart';
import 'package:food_sub/ui/common/ui_helpers.dart';
import 'package:food_sub/ui/common/uihelper/text_helper.dart';
import 'package:food_sub/ui/widgets/common/addpromotionhelper/addpromotionhelper.dart';
import 'package:stacked/stacked.dart';

import '../../../../common/uihelper/snakbar_helper.dart';
import 'addpromotions_viewmodel.dart';

class AddpromotionsView extends StackedView<AddpromotionsViewModel> {
  const AddpromotionsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddpromotionsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: text_helper(
          data: "Add Promotion",
          font: nunito,
          color: kcDarkGreyColor,
          size: fontSize14,
          bold: true,
        ),
        actions: [
          InkWell(
            onTap: () {
              viewModel.notifyListeners();
            },
            child: const Padding(
                padding: EdgeInsets.all(8.0), child: Icon(Icons.refresh)),
          ),
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: ApiHelper.allpromotionbynum(
            viewModel.sharedpref.readString("number")),
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
                          offset:
                              const Offset(0, 2), // changes position of shadow
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
                          placeholder: (context, url) =>
                              displaysimpleprogress(context),
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
                                  data: "Discount : " +
                                      snapshot.data[index]['dis'],
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
                                  data:
                                      "Code : " + snapshot.data[index]['code'],
                                  font: nunito,
                                  color: kcDarkGreyColor,
                                  size: fontSize12),
                            ],
                          ),
                        ),
                        horizontalSpaceSmall,
                        InkWell(
                            onTap: () => viewModel.delete(
                                context, snapshot.data[index]['_id']),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        horizontalSpaceSmall,
                      ],
                    ),
                  );
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
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (BuildContext context) {
                return const Dialog(
                  child: Addpromotionhelper(),
                );
              });
          viewModel.notifyListeners();
        },
        backgroundColor: kcPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  AddpromotionsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddpromotionsViewModel();
}
