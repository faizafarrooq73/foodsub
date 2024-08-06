import 'package:flutter/cupertino.dart';
import 'package:food_sub/ui/common/apihelpers/apihelper.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/app.locator.dart';
import '../../../../../services/sharedpref_service.dart';

class AddpromotionsViewModel extends BaseViewModel {
  final sharedpref = locator<SharedprefService>();

  Future<void> delete(BuildContext context, String id) async {
    await ApiHelper.deletepromotion(id);
    notifyListeners();
  }
}
