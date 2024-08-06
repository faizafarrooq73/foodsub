import 'package:flutter/cupertino.dart';
import 'package:food_sub/services/sharedpref_service.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/app.locator.dart';

class ChatingViewModel extends BaseViewModel {
  final sharedpref = locator<SharedprefService>();
  TextEditingController chat = TextEditingController();
}
