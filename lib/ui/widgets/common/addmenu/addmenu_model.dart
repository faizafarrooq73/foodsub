import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:food_sub/ui/common/apihelpers/firebsaeuploadhelper.dart';
import 'package:food_sub/ui/common/uihelper/snakbar_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/app.locator.dart';
import '../../../../services/sharedpref_service.dart';
import '../../../common/apihelpers/apihelper.dart';

class AddmenuModel extends BaseViewModel {
  final sharedpref = locator<SharedprefService>();

  TextEditingController name = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController price = TextEditingController();

  String type = "menu";

  File? image;
  Future<void> pic() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  String imagep = '';
  String id = '';
  bool updatev = false;
  void update(Map e) {
    if (e.isNotEmpty) {
      name.text = e['itemname'];
      price.text = e['itemprice'];
      des.text = e['itemdes'];
      imagep = e['image'];
      id = e['_id'];
      selected = e['cat'];
      type = e['type'];
      updatev = true;
    }
  }

  Future<void> updateactual(BuildContext context) async {
    if (name.text.isEmpty || price.text.isEmpty || des.text.isEmpty) {
      show_snackbar(context, "Enter data");
    } else {
      displayprogress(context);
      String url = imagep;
      if (image != null) {
        url = await FirebaseHelper.uploadFile(
            File(image!.path), sharedpref.readString("number"));
      }
      bool check = await ApiHelper.updatemenu(
          id, name.text, price.text, des.text, url, selected, type, context);
      if (check) {
        hideprogress(context);
        Navigator.pop(context);
      } else {
        hideprogress(context);
      }
    }
  }

  Future<void> add(BuildContext context) async {
    if (name.text.isEmpty || des.text.isEmpty || price.text.isEmpty) {
      show_snackbar(context, "Fill all fields");
    } else if (selected == '') {
      show_snackbar(context, "Add Item First");
    } else {
      displayprogress(context);
      String url = await FirebaseHelper.uploadFile(
          File(image!.path), sharedpref.readString('number'));
      bool check = await ApiHelper.menuregistration(
          sharedpref.readString('number'),
          name.text,
          price.text,
          des.text,
          url,
          selected,
          type,
          context);
      if (check) {
        hideprogress(context);
        Navigator.pop(context);
      } else {
        hideprogress(context);
      }
    }
  }

  List<String> item = [];
  String selected = '';
  bool c = true;
  void additems(List data) {
    if (c) {
      for (var element in data) {
        item.add(element['name']);
      }
      if (item.isNotEmpty) {
        selected = item[0];
      }
      c = false;
    }
  }

  Future<void> delete(BuildContext context) async {
    displayprogress(context);
    await ApiHelper.deletemenu(id, context);
    hideprogress(context);
    Navigator.pop(context);
  }
}
