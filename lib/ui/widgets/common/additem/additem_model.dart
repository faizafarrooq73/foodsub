import 'package:flutter/cupertino.dart';
import 'package:food_sub/ui/common/apihelpers/apihelper.dart';
import 'package:food_sub/ui/common/uihelper/snakbar_helper.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/app.locator.dart';
import '../../../../services/sharedpref_service.dart';

class AdditemModel extends BaseViewModel {
  final sharedpref = locator<SharedprefService>();

  TextEditingController item = TextEditingController();

  Future<void> additem(BuildContext context) async {
    if (item.text.isEmpty) {
      show_snackbar(context, "Fill all items");
    } else {
      displayprogress(context);
      await ApiHelper.registeritem(
          item.text, sharedpref.readString('number'), context);
      item.clear();
      hideprogress(context);
      notifyListeners();
    }
  }

  Future<void> delete(String id) async {
    await ApiHelper.deleteitem(id);
    notifyListeners();
  }
}
