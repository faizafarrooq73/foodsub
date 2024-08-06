import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:food_sub/ui/common/apihelpers/apihelper.dart';
import 'package:food_sub/ui/common/app_colors.dart';
import 'package:food_sub/ui/common/app_strings.dart';
import 'package:food_sub/ui/common/ui_helpers.dart';
import 'package:food_sub/ui/common/uihelper/button_helper.dart';
import 'package:food_sub/ui/common/uihelper/text_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../common/uihelper/snakbar_helper.dart';
import 'booknow_viewmodel.dart';

class BooknowView extends StackedView<BooknowViewModel> {
  BooknowView({Key? key, required this.acess, this.appbarshow = true})
      : super(key: key);
  String acess;
  bool appbarshow;
  // acess == user,rider,rest

  @override
  Widget builder(
    BuildContext context,
    BooknowViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        appBar: appbarshow
            ? AppBar(
                backgroundColor: kcPrimaryColor,
                title: text_helper(
                    data: "Orders ",
                    font: nunito,
                    color: kcDarkGreyColor,
                    bold: true,
                    size: fontSize16),
                actions: [
                  InkWell(
                    onTap: () {
                      viewModel.notifyListeners();
                    },
                    child: const Icon(Icons.refresh),
                  ),
                  horizontalSpaceSmall,
                ],
              )
            : const PreferredSize(
                preferredSize: Size.zero, child: SizedBox.shrink()),
        body: SafeArea(
          child: Column(
            children: [
              Row(children: [
                btn("all", viewModel),
                btn("new", viewModel),
                btn("schedule", viewModel),
                btn("delivery", viewModel),
                btn("old", viewModel),
              ]),
              Expanded(
                child: FutureBuilder(
                  future: acess == 'user'
                      ? ApiHelper.getbyuser(
                          viewModel.sharedpref.readString('number'))
                      : acess == 'rest'
                          ? ApiHelper.getbyrest(
                              viewModel.sharedpref.readString('number'))
                          : acess == 'rider' &&
                                  (viewModel.val == 'new' ||
                                      viewModel.val == 'schedule')
                              ? ApiHelper.getbyriderstatus()
                              : ApiHelper.getbyrider(
                                  viewModel.sharedpref.readString('number')),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
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
                              if (viewModel.val == 'all') {
                                return listdata(
                                    context, snapshot.data[index], viewModel);
                              } else {
                                if (viewModel.val ==
                                    snapshot.data[index]['status']) {
                                  return listdata(
                                      context, snapshot.data[index], viewModel);
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }
                            });
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
        ));
  }

  Widget listdata(BuildContext context, Map<String, dynamic> data,
      BooknowViewModel viewModel) {
    return InkWell(
      onTap: () {
        dialog(context, data);
      },
      child: Container(
        width: screenWidth(context),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: getColorWithOpacity(kcVeryLightGrey, 0.3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: linnerrow("Status", data['status'], Icons.menu)),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          viewModel.chat(
                              data['custnumber'], data['restnumber']);
                        },
                        child: const Icon(Icons.chat_bubble)),
                    data['ridernumber'] == ""
                        ? const SizedBox.shrink()
                        : InkWell(
                            onTap: () {
                              viewModel.chat(
                                  data['custnumber'], data['ridernumber']);
                            },
                            child: const Icon(Icons.chat_bubble_outline))
                  ],
                )
              ],
            ),
            text_helper(
              data: "Click to view order menu",
              font: nunito,
              color: kcPrimaryColor,
              size: fontSize14,
              bold: true,
            ),
            linnerrow("Discount", data['dis'], Icons.discount),
            text_helper(
              data: data['datetime'],
              font: nunito,
              color: kcDarkGreyColor,
              size: fontSize12,
              bold: true,
            ),
            address(context, data, viewModel),
            maps(context, data, viewModel),
            conditions(context, data, viewModel),
          ],
        ),
      ),
    );
  }

  Widget maps(BuildContext context, Map<String, dynamic> data,
      BooknowViewModel viewModel) {
    return data['status'] == "old"
        ? const SizedBox.shrink()
        : data['status'] == "delivery"
            ? SizedBox(
                width: screenWidth(context),
                height: 150,
                child: GoogleMap(
                  onTap: (LatLng latLng) {
                    mapdialog(context, data);
                  },
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(data['ulat'].toString()),
                        double.parse(data['ulon'].toString())),
                    zoom: 15.0,
                  ),
                  polylines: {
                    Polyline(
                      points: [
                        LatLng(double.parse(data['ulat'].toString()),
                            double.parse(data['ulon'].toString())),
                        LatLng(double.parse(data['clat'].toString()),
                            double.parse(data['clon'].toString()))
                      ],
                      color: kcPrimaryColor,
                      width: 5,
                      polylineId: const PolylineId("deilvery"),
                    ),
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('marker'),
                      position: LatLng(double.parse(data['ulat'].toString()),
                          double.parse(data['ulon'].toString())),
                    ),
                    Marker(
                      markerId: const MarkerId('marker'),
                      position: LatLng(double.parse(data['clat'].toString()),
                          double.parse(data['clon'].toString())),
                    )
                  },
                ),
              )
            : SizedBox(
                width: screenWidth(context),
                height: 150,
                child: GoogleMap(
                  onTap: (LatLng latLng) {
                    mapdialog(context, data);
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(data['ulat'].toString()),
                        double.parse(data['ulon'].toString())),
                    zoom: 15.0,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('marker'),
                      position: LatLng(double.parse(data['ulat'].toString()),
                          double.parse(data['ulon'].toString())),
                    )
                  },
                ),
              );
  }

  void mapdialog(BuildContext context, Map<String, dynamic> data) {
    showDialog(
        context: context,
        builder: (BuildContext context) => data['status'] == "old"
            ? const SizedBox.shrink()
            : data['status'] == "delivery"
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(data['ulat'].toString()),
                          double.parse(data['ulon'].toString())),
                      zoom: 15.0,
                    ),
                    polylines: {
                      Polyline(
                        points: [
                          LatLng(double.parse(data['ulat'].toString()),
                              double.parse(data['ulon'].toString())),
                          LatLng(double.parse(data['clat'].toString()),
                              double.parse(data['clon'].toString()))
                        ],
                        color: kcPrimaryColor,
                        width: 5,
                        polylineId: const PolylineId("deilvery"),
                      ),
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId('marker'),
                        position: LatLng(double.parse(data['ulat'].toString()),
                            double.parse(data['ulon'].toString())),
                      ),
                      Marker(
                        markerId: const MarkerId('marker'),
                        position: LatLng(double.parse(data['clat'].toString()),
                            double.parse(data['clon'].toString())),
                      )
                    },
                  )
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(data['ulat'].toString()),
                          double.parse(data['ulon'].toString())),
                      zoom: 15.0,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('marker'),
                        position: LatLng(double.parse(data['ulat'].toString()),
                            double.parse(data['ulon'].toString())),
                      )
                    },
                  ));
  }

  Widget address(BuildContext context, Map<String, dynamic> data,
      BooknowViewModel viewModel) {
    return FutureBuilder(
      future: viewModel.getAddressFromLatLng(
          double.parse(data['ulat'].toString()),
          double.parse(data['ulon'].toString())),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return text_helper(
            data: snapshot.data.toString(),
            textAlign: TextAlign.start,
            font: nunito,
            color: kcDarkGreyColor,
            size: fontSize10,
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
    );
  }

  Widget conditions(
      BuildContext context, Map data, BooknowViewModel viewModel) {
    return Column(
      children: [
        data['sechdule'] == "true"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceSmall,
                  text_helper(
                    data: "This Order is Scheduled",
                    font: nunito,
                    color: Colors.red,
                    size: fontSize12,
                    bold: true,
                  ),
                  linnerrow(
                      "Total Days", data['sechduledays'], Icons.calendar_month),
                  linnerrow(
                      "Scheduling Time", data['sechduletime'], Icons.timelapse),
                ],
              )
            : const SizedBox.shrink(),
        (acess == 'rest' && data['reststatus'] == 'new')
            ? button_helper(
                onpress: () => viewModel.changereststatus(context, data['_id']),
                color: Colors.green,
                width: screenWidth(context),
                child: text_helper(
                  data: "Accept Order",
                  font: nunito,
                  color: white,
                  size: fontSize14,
                  bold: true,
                ))
            : const SizedBox.shrink(),
        (acess == 'rider' && data['riderstatus'] == 'new')
            ? button_helper(
                onpress: () =>
                    viewModel.changeriderstatus(context, data['_id'], data),
                color: Colors.green,
                width: screenWidth(context),
                child: text_helper(
                  data: "Accept Order",
                  font: nunito,
                  color: white,
                  size: fontSize14,
                  bold: true,
                ))
            : const SizedBox.shrink(),
        (acess == 'rider' && data['status'] == 'delivery')
            ? viewModel.isFutureDate(
                    data['datetime'], int.parse(data['sechduledays']))
                ? text_helper(
                    data: "Order Not Complete",
                    font: nunito,
                    color: Colors.red,
                    size: fontSize14,
                    bold: true,
                  )
                : const SizedBox.shrink()
            : const SizedBox.shrink(),
        (acess == 'rider' && data['status'] == 'delivery')
            ? button_helper(
                onpress: () => viewModel.changestatus(context, data['_id']),
                color: Colors.green,
                width: screenWidth(context),
                child: text_helper(
                  data: "Done Order",
                  font: nunito,
                  color: white,
                  size: fontSize14,
                  bold: true,
                ))
            : const SizedBox.shrink(),
      ],
    );
  }

  void dialog(BuildContext context, Map data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: ListView(
              shrinkWrap: true,
              reverse: true,
              children: data['menu']
                  .map<Widget>((e) => Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: getColorWithOpacity(kcPrimaryColor, 0.1),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              linnerrow(
                                  "item name", e['itemname'], Icons.fastfood),
                              linnerrow("Total Price", e['editprice'],
                                  Icons.price_change_sharp),
                              linnerrow("Total Quantity", e['quantity'],
                                  Icons.production_quantity_limits_outlined)
                            ]),
                      ))

                  .toList(),

            ),
          );
        });
  }

  Widget linnerrow(String title, String des, IconData iconData,
      {color = kcPrimaryColor}) {
    return Row(
      children: [
        Icon(iconData, color: color),
        horizontalSpaceSmall,
        text_helper(
            data: title,
            font: nunito,
            color: kcDarkGreyColor,
            size: fontSize14,
            bold: true),
        horizontalSpaceSmall,
        Expanded(
          child: text_helper(
              data: des,
              textAlign: TextAlign.start,
              font: nunito,
              color: kcDarkGreyColor,
              size: fontSize14),
        ),
      ],
    );
  }

  Widget btn(String title, BooknowViewModel viewModel) {
    return InkWell(
      onTap: () {
        viewModel.val = title;
        viewModel.notifyListeners();
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: kcPrimaryColor,
            ),
            color: viewModel.val == title
                ? kcPrimaryColor
                : getColorWithOpacity(kcVeryLightGrey, 0.3)),
        child: text_helper(
            data: title,
            font: nunito,
            color: viewModel.val != title ? kcPrimaryColor : white,
            size: fontSize14,
            bold: true),
      ),
    );
  }

  @override
  Future<void> onViewModelReady(BooknowViewModel viewModel) async {
    await Permission.locationAlways.request();
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(BooknowViewModel viewModel) {
    viewModel.positionStream?.cancel();
    super.onDispose(viewModel);
  }

  @override
  BooknowViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BooknowViewModel();
}
