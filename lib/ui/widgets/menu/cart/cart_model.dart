import 'package:flutter/material.dart';
import 'package:food_sub/ui/common/uihelper/snakbar_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../services/sharedpref_service.dart';
import '../../../common/apihelpers/apihelper.dart';

class CartModel extends BaseViewModel {
  final _sharedpref = locator<SharedprefService>();
  final _navigationService = locator<NavigationService>();

  TextEditingController discount = TextEditingController();

  bool schedule = false;
  String time = '';
  String days = '0';

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      time = pickedTime.format(context);
      notifyListeners();
    }
  }

  List menus = [];
  void first(List men) {
    for (int i = 0; i < men.length; i++) {
      Map fdata = {};
      fdata['_id'] = men[i]['_id'];
      fdata['itemname'] = men[i]['itemname'];
      fdata['itemprice'] = men[i]['itemprice'];
      fdata['editprice'] = men[i]['itemprice'];
      fdata['itemdes'] = men[i]['itemdes'];
      fdata['quantity'] = '1';
      menus.add(fdata);
    }
  }

  void plus(int index) {
    Map data = menus[index];
    data['editprice'] =
        '${int.parse(data['editprice']) + int.parse(data['itemprice'])}';
    data['quantity'] = '${int.parse(data['quantity']) + 1}';
    notifyListeners();
  }

  void minus(int index) {
    Map data = menus[index];
    if (int.parse(data['quantity']) > 0) {
      data['editprice'] =
          '${int.parse(data['editprice']) - int.parse(data['itemprice'])}';
      data['quantity'] = '${int.parse(data['quantity']) - 1}';
      notifyListeners();
    }
  }

  int d = 0;

  Future<void> book(BuildContext context, String number) async {
    if(discount.text.isNotEmpty){
      Map pdata = await ApiHelper.promotionbycode(discount.text);
      if(pdata.isNotEmpty){
        d = int.parse(pdata['dis']);
      }else{
        d = 0;
      }
    }
    if (!schedule) {
      register(context, number, 'new');
    } else {
      if (time == '' || days == '0') {
        show_snackbar(context, 'Fill all fields');
      } else {
        register(context, number, 'schedule');
      }
    }
  }

  Future<void> register(
      BuildContext context, String number, String status) async {
    displayprogress(context);
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      timeLimit: const Duration(seconds: 5),
      forceAndroidLocationManager: true,
    );
    double latitude = position.latitude;
    double longitude = position.longitude;
    bool result = await ApiHelper.registeroder(
        number,
        _sharedpref.readString('number'),
        DateTime.now().toString().substring(0, 10),
        menus,
        "",
        "",
        latitude.toString(),
        longitude.toString(),
        schedule.toString(),
        days,
        time,
        status,
        d.toString(),
        context);
    _navigationService.back();
    _navigationService.back();
    if (result) {
      show_snackbar(context, "Order Placed");
    }
  }

  List<String> dayss = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'];
}
