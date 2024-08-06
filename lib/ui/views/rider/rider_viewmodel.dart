import 'package:food_sub/ui/views/chat/allchats/allchats_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/sharedpref_service.dart';
import '../loginsignup/loginsignup_view.dart';

class RiderViewModel extends BaseViewModel {
  final sharedpref = locator<SharedprefService>();
  final _navigationService = locator<NavigationService>();

  void allchat() {
    _navigationService.navigateWithTransition(const AllchatsView(),
        routeName: Routes.allchatsView,
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
}
