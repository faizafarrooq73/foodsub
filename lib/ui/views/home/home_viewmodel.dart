import 'package:flutter/cupertino.dart';
import 'package:food_sub/ui/views/customerspecials/promotion/showpromotions/showpromotions_view.dart';
import 'package:food_sub/ui/views/customerspecials/showdeals/showdeals_view.dart';
import 'package:food_sub/ui/views/menuselection/menuselection_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/sharedpref_service.dart';
import '../booknow/booknow_view.dart';
import '../chat/allchats/allchats_view.dart';
import '../loginsignup/loginsignup_view.dart';

class HomeViewModel extends BaseViewModel {
  final sharedpref = locator<SharedprefService>();
  final _navigationService = locator<NavigationService>();

  TextEditingController searchBar = TextEditingController();

  void move(String number) {
    _navigationService.navigateWithTransition(
        MenuselectionView(
          number: number,
        ),
        routeName: Routes.menuselectionView,
        transitionStyle: Transition.rightToLeft);
  }

  void login() {
    sharedpref.remove('name');
    sharedpref.remove('cnic');
    sharedpref.remove('number');
    sharedpref.remove('address');
    sharedpref.remove('dob');
    sharedpref.remove('cat');
    sharedpref.remove('img');
    sharedpref.remove('deviceid');
    sharedpref.setString("auth", 'false');
    _navigationService.clearStackAndShow(Routes.loginsignupView);
    _navigationService.replaceWithTransition(const LoginsignupView(),
        routeName: Routes.loginsignupView,
        transitionStyle: Transition.rightToLeft);
  }

  void order() {
    _navigationService.navigateWithTransition(
        BooknowView(
          acess: "user",
        ),
        routeName: Routes.booknowView,
        transitionStyle: Transition.rightToLeft);
  }

  void allchat() {
    _navigationService.navigateWithTransition(const AllchatsView(),
        routeName: Routes.allchatsView,
        transitionStyle: Transition.rightToLeft);
  }

  void deal() {
    _navigationService.navigateWithTransition(const ShowdealsView(),
        routeName: Routes.showdealsView,
        transitionStyle: Transition.rightToLeft);
  }

  void promotion() {
    _navigationService.navigateWithTransition(const ShowpromotionsView(),
        routeName: Routes.showpromotionsView,
        transitionStyle: Transition.rightToLeft);
  }
}
