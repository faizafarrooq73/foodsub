import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_sub/ui/common/app_colors.dart';
import 'package:food_sub/ui/common/app_strings.dart';
import 'package:food_sub/ui/common/ui_helpers.dart';
import 'package:food_sub/ui/common/uihelper/text_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../common/uihelper/button_helper.dart';
import '../../common/uihelper/text_veiw_helper.dart';
import 'loginsignup_viewmodel.dart';

class LoginsignupView extends StackedView<LoginsignupViewModel> {
  const LoginsignupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginsignupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: screenWidth(context),
                  color: kcPrimaryColor,
                  padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text_helper(
                                  data: "Welcome To   ",
                                  font: openSans,
                                  bold: true,
                                  color: kcDarkGreyColor,
                                  size: fontSize18),
                              text_helper(
                                  data: "   Sign Up and Login",
                                  font: openSans,
                                  color: kcDarkGreyColor,
                                  size: fontSize10)
                            ],
                          ),
                          text_helper(
                              data: "Food Sub",
                              font: birthstone,
                              bold: true,
                              color: kcDarkGreyColor,
                              size: fontSize30 + 5),
                        ],
                      ),
                      Image.asset(
                        "assets/burger.png",
                        width: screenWidthCustom(context, 0.15),
                        height: screenWidthCustom(context, 0.15),
                      ),
                    ],
                  )),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Image.asset(
                      'assets/bac.jpg',
                      width: screenWidth(context),
                      fit: BoxFit.cover,
                    )),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: kcDarkGreyColor,
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: TabBar(
                              dividerHeight: 0,
                              isScrollable: true,
                              unselectedLabelColor: kcLightGrey,
                              labelColor: white,
                              indicatorColor: white,
                              labelStyle: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize18),
                              tabs: viewModel.tabs,
                              onTap: (index) {
                                viewModel.currentindex = index;
                                viewModel.notifyListeners();
                              },
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Tab0(viewModel, context),
                                Tab1(viewModel, context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget Tab0(LoginsignupViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            text_view_helper(
              hint: "Enter Phone No",
              controller: viewModel.phone,
              showicon: true,
              textInputType: TextInputType.phone,
              maxlength: 11,
              formatter: [FilteringTextInputFormatter.allow(getRegExpint())],
              icon: const Icon(Icons.phone),
            ).animate(delay: 500.milliseconds).fade().moveY(begin: 50, end: 0),
            text_view_helper(
              hint: "Enter Password",
              controller: viewModel.pass,
              showicon: true,
              obsecure: true,
              icon: const Icon(Icons.password),
            ).animate(delay: 700.milliseconds).fade().moveY(begin: 50, end: 0),
            button_helper(
                    onpress: () => viewModel.login(context),
                    color: kcDarkGreyColor,
                    height: screenWidthCustom(context, 0.15),
                    width: screenWidthCustom(context, 0.15),
                    raduis: 100,
                    child: const Icon(
                      Icons.arrow_forward,
                      color: white,
                      size: 40,
                    ))
                .animate(delay: 900.milliseconds)
                .fade()
                .moveY(begin: 50, end: 0)
          ],
        ),
      ),
    );
  }

  Widget data(BuildContext context, title, des, img) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          img,
          width: screenWidthCustom(context, 0.1),
          height: screenWidthCustom(context, 0.1),
        ),
        horizontalSpaceTiny,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text_helper(
                  data: title,
                  font: nunito,
                  bold: true,
                  color: kcDarkGreyColor,
                  size: fontSize16),
              text_helper(
                  data: des,
                  font: nunito,
                  textAlign: TextAlign.start,
                  color: kcDarkGreyColor,
                  size: fontSize12),
            ],
          ),
        ),
      ],
    );
  }

  Widget Tab1(LoginsignupViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpaceMedium,
            Container(
              width: screenWidthCustom(context, 0.25),
              height: screenWidthCustom(context, 0.25),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(2, 2),
                        blurRadius: 1,
                        spreadRadius: 1,
                        color: getColorWithOpacity(kcDarkGreyColor, 0.2))
                  ],
                  border: Border.all(
                      width: 3,
                      color: kcDarkGreyColor,
                      strokeAlign: BorderSide.strokeAlignOutside)),
              child: InkWell(
                onTap: () => viewModel.pic(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: viewModel.image == null
                      ? const Icon(
                          Icons.person,
                          size: 80,
                        )
                      : Image.file(
                          viewModel.image!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ).animate(delay: 500.milliseconds).fade().moveY(begin: 50, end: 0),
            verticalSpaceSmall,
            SizedBox(
              width: screenWidth(context),
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  button_helper(
                      onpress: () => viewModel.user(),
                      color: white,
                      width: screenWidthCustom(context, 0.4),
                      boxshadow: [
                        BoxShadow(
                            offset: const Offset(2, 2),
                            blurRadius: 1,
                            spreadRadius: 1,
                            color: getColorWithOpacity(kcDarkGreyColor, 0.2))
                      ],
                      border: Border.all(
                          width: 2,
                          color: viewModel.cat == 'user'
                              ? kcDarkGreyColor
                              : white),
                      child: data(context, "User", "Are you hungry",
                          'assets/user.png')),
                  button_helper(
                      onpress: () => viewModel.provider(),
                      color: white,
                      width: screenWidthCustom(context, 0.4),
                      boxshadow: [
                        BoxShadow(
                            offset: const Offset(2, 2),
                            blurRadius: 1,
                            spreadRadius: 1,
                            color: getColorWithOpacity(kcDarkGreyColor, 0.2))
                      ],
                      border: Border.all(
                          width: 2,
                          color: viewModel.cat == 'provider'
                              ? kcDarkGreyColor
                              : white),
                      child: data(context, "Provider",
                          "Begin your own business", 'assets/provider.png')),
                  button_helper(
                      onpress: () => viewModel.rider(),
                      color: white,
                      width: screenWidthCustom(context, 0.4),
                      boxshadow: [
                        BoxShadow(
                            offset: const Offset(2, 2),
                            blurRadius: 1,
                            spreadRadius: 1,
                            color: getColorWithOpacity(kcDarkGreyColor, 0.2))
                      ],
                      border: Border.all(
                          width: 2,
                          color: viewModel.cat == 'rider'
                              ? kcDarkGreyColor
                              : white),
                      child: data(context, "Rider", "Start Incoming now",
                          'assets/rider.png')),
                ],
              )
                  .animate(delay: 500.milliseconds)
                  .fade()
                  .moveY(begin: 50, end: 0),
            ),
            text_view_helper(
              hint: "Enter name",
              controller: viewModel.name,
              showicon: true,
            ).animate(delay: 700.milliseconds).fade().moveY(begin: 50, end: 0),
            text_view_helper(
              hint: "Enter number",
              controller: viewModel.number,
              showicon: true,
              icon: const Icon(Icons.call),
              maxlength: 11,
              formatter: [FilteringTextInputFormatter.allow(getRegExpint())],
              textInputType: TextInputType.phone,
            ).animate(delay: 900.milliseconds).fade().moveY(begin: 50, end: 0),
            text_view_helper(
              hint: "Enter cnic",
              controller: viewModel.cnic,
              showicon: true,
              icon: const Icon(Icons.dock),
              maxlength: 13,
              formatter: [FilteringTextInputFormatter.allow(getRegExpint())],
              textInputType: TextInputType.phone,
            ).animate(delay: 1100.milliseconds).fade().moveY(begin: 50, end: 0),
            text_view_helper(
                    hint: "Enter address",
                    controller: viewModel.address,
                    showicon: true,
                    icon: const Icon(Icons.home))
                .animate(delay: 1300.milliseconds)
                .fade()
                .moveY(begin: 50, end: 0),
            InkWell(
              onTap: () => viewModel.selectdob(context),
              child: Container(
                width: screenWidthCustom(context, 0.9),
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: const Offset(2, 2),
                      blurRadius: 1,
                      spreadRadius: 1,
                      color: getColorWithOpacity(kcDarkGreyColor, 0.2))
                ], borderRadius: BorderRadius.circular(10), color: white),
                child: Row(
                  children: [
                    horizontalSpaceSmall,
                    const Icon(Icons.date_range),
                    horizontalSpaceSmall,
                    text_helper(
                        data: viewModel.dob.text == ''
                            ? "Select Date of Birth"
                            : viewModel.dob.text,
                        font: nunito,
                        color: viewModel.dob.text == ''
                            ? kcDarkGreyColor
                            : kcDarkGreyColor,
                        size: fontSize14),
                  ],
                ),
              ),
            ).animate(delay: 1500.milliseconds).fade().moveY(begin: 50, end: 0),
            text_view_helper(
                    hint: "Enter password",
                    controller: viewModel.passs,
                    showicon: true,
                    obsecure: true,
                    icon: const Icon(Icons.password))
                .animate(delay: 1700.milliseconds)
                .fade()
                .moveY(begin: 50, end: 0),
            text_view_helper(
                    hint: "Enter password again",
                    controller: viewModel.conpass,
                    showicon: true,
                    obsecure: true,
                    icon: const Icon(Icons.password))
                .animate(delay: 1900.milliseconds)
                .fade()
                .moveY(begin: 50, end: 0),
            verticalSpaceSmall,
            button_helper(
                    onpress: () => viewModel.next(context),
                    color: kcDarkGreyColor,
                    height: screenWidthCustom(context, 0.15),
                    width: screenWidthCustom(context, 0.15),
                    raduis: 100,
                    child: const Icon(
                      Icons.arrow_forward,
                      color: white,
                      size: 40,
                    ))
                .animate(delay: 2100.milliseconds)
                .fade()
                .moveY(begin: 50, end: 0),
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(LoginsignupViewModel viewModel) => viewModel.first();

  @override
  LoginsignupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginsignupViewModel();
}
