import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_sub/ui/common/apihelpers/apihelper.dart';
import 'package:food_sub/ui/common/uihelper/snakbar_helper.dart';
import 'package:food_sub/ui/views/provider/provider_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/sharedpref_service.dart';
import '../../common/apihelpers/firebsaeuploadhelper.dart';

class RiderproviderViewModel extends BaseViewModel {
  final sharedpref = locator<SharedprefService>();
  final _navigationService = locator<NavigationService>();

  TextEditingController restname = TextEditingController();
  TextEditingController opening = TextEditingController();
  TextEditingController closing = TextEditingController();

  File? image;
  Future<void> pic() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> selectTime(BuildContext context, bool check) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      if (check) {
        opening.text = picked.format(context);
      } else {
        closing.text = picked.format(context);
      }
      notifyListeners();
    }
  }

  Future<void> registerrest(BuildContext context) async {
    if (restname.text.isEmpty || opening.text.isEmpty || closing.text.isEmpty) {
      show_snackbar(context, "Opening and closing must be different");
    } else if (opening.text == closing.text) {
      show_snackbar(context, "Enter all fields");
    } else {
      displayprogress(context);

      String url = await FirebaseHelper.uploadFile(
          image!, sharedpref.readString('number'));

      bool val = await ApiHelper.registerrest(sharedpref.readString('number'),
          restname.text, opening.text, closing.text, url, context);

      if (val) {
        sharedpref.setString("auth", 'true');
        _navigationService.clearStackAndShow(Routes.riderproviderView);
        _navigationService.replaceWithTransition(const ProviderView(),
            routeName: Routes.providerView,
            transitionStyle: Transition.rightToLeft);
      }
    }
  }
}
