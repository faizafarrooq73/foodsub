import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_sub/ui/common/apihelpers/apihelper.dart';
import 'package:food_sub/ui/common/apihelpers/firebsaeuploadhelper.dart';
import 'package:food_sub/ui/common/uihelper/snakbar_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/app.locator.dart';
import '../../../../services/sharedpref_service.dart';

class AddpromotionhelperModel extends BaseViewModel {
  final sharedpref = locator<SharedprefService>();

  TextEditingController dis = TextEditingController();
  TextEditingController date = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      date.text = picked.toString().substring(0, 10);
      notifyListeners();
    }
  }

  File? imageFile;
  Future<void> pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        imageFile = File(image.path);
        notifyListeners();
      }
    } catch (e) {}
  }

  Future<void> add(BuildContext context) async {
    if (imageFile == null) {
      show_snackbar(context, "Please select image");
    } else if (dis.text.isEmpty) {
      show_snackbar(context, "Please enter discount");
    } else if (date.text.isEmpty) {
      show_snackbar(context, "Please select a send date");
    } else if (int.parse(dis.text) > 100) {
      show_snackbar(context, "Discount must be less than 100");
    } else {
      displayprogress(context);
      String url = await FirebaseHelper.uploadFile(
          imageFile, sharedpref.readString("number"));
      bool c = await ApiHelper.registerpromotion(
          sharedpref.readString("number"), url, dis.text, date.text);
      hideprogress(context);
      if (c) {
        show_snackbar(context, "Promotion added");
        Navigator.pop(context);
      } else {
        show_snackbar(context, "Something went wrong");
        Navigator.pop(context);
      }
    }
  }
}
