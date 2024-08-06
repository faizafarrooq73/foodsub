import 'package:flutter/material.dart';
import 'package:food_sub/ui/widgets/menu/cart/cart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../common/uihelper/snakbar_helper.dart';

class MenuselectionViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void back() {
    _navigationService.back();
  }

  String s = '';
  void item(String sel) {
    s = sel;
    notifyListeners();
  }

  bool c = true;
  Future<void> itemf(String sel) async {
    if (c) {
      s = sel;
      await Future.delayed(const Duration(milliseconds: 500));
      c = false;
      notifyListeners();
    }
  }

  List cart = [];
  int price = 0;
  void cartt(Map e) {
    if (cart.isEmpty) {
      cart.add(e);
      priceadd();
      notifyListeners();
    } else {
      if (!checking(e['itemname'], e['itemdes'])) {
        cart.add(e);
        priceadd();
        notifyListeners();
      } else {
        remove(e['itemname'], e['itemdes']);
        priceadd();
        notifyListeners();
      }
    }
  }

  void remove(String name, String itemdes) {
    for (var element in cart) {
      if (name == element['itemname'] && itemdes == element['itemdes']) {
        cart.remove(element);
        break;
      }
    }
  }

  void priceadd() {
    price = 0;
    for (var element in cart) {
      price += int.parse(element['itemprice']);
    }
  }

  bool checking(String name, String itemdes) {
    for (var element in cart) {
      if (name == element['itemname'] && itemdes == element['itemdes']) {
        return true;
      }
    }
    return false;
  }

  void order(BuildContext context, String restnumber) {
    if (cart.isEmpty) {
      show_snackbar(context, "Select a table to continue");
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Cart(cart: cart, restnumber: restnumber),
            );
          });
    }
  }

  Future<void> first() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }
  }
}
