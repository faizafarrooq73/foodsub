import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../menuselection/menuselection_view.dart';

class ShowdealsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void move(String number) {
    _navigationService.navigateWithTransition(
        MenuselectionView(
          number: number,
        ),
        routeName: Routes.menuselectionView,
        transitionStyle: Transition.rightToLeft);
  }
}
