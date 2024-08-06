import 'package:flutter/services.dart';
import 'package:food_sub/ui/views/home/home_view.dart';
import 'package:food_sub/ui/views/loginsignup/loginsignup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:food_sub/app/app.locator.dart';
import 'package:food_sub/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/sharedpref_service.dart';
import '../provider/provider_view.dart';
import '../rider/rider_view.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _sharedpref = locator<SharedprefService>();

  Future runStartupLogic() async {
    _sharedpref.initialize();
    hideStatusBar();
    await Future.delayed(const Duration(seconds: 3));
    if (_sharedpref.contains('auth') &&
        _sharedpref.readString('auth') == 'true') {
      showStatusBar();
      if (_sharedpref.readString('cat') == 'provider') {
        _navigationService.clearStackAndShow(Routes.providerView);
        _navigationService.replaceWithTransition(const ProviderView(),
            routeName: Routes.providerView,
            transitionStyle: Transition.rightToLeft);
      } else if (_sharedpref.readString('cat') == 'user') {
        _navigationService.clearStackAndShow(Routes.homeView);
        _navigationService.replaceWithTransition(const HomeView(),
            routeName: Routes.homeView,
            transitionStyle: Transition.rightToLeft);
      } else {
        _navigationService.clearStackAndShow(Routes.riderView);
        _navigationService.replaceWithTransition(const RiderView(),
            routeName: Routes.riderView,
            transitionStyle: Transition.rightToLeft);
      }
    } else {
      _navigationService.clearStackAndShow(Routes.loginsignupView);
      _navigationService.replaceWithTransition(const LoginsignupView(),
          routeName: Routes.loginsignupView,
          transitionStyle: Transition.rightToLeft);
    }
  }

  void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    notifyListeners();
  }

  void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    notifyListeners();
  }
}
