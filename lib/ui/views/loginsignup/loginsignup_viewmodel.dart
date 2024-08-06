import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:food_sub/ui/views/home/home_view.dart';
import 'package:food_sub/ui/views/provider/provider_view.dart';
import 'package:food_sub/ui/views/rider/rider_view.dart';
import 'package:food_sub/ui/views/riderprovider/riderprovider_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:intl/intl.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/fire_service.dart';
import '../../../services/sharedpref_service.dart';
import '../../common/apihelpers/apihelper.dart';
import '../../common/apihelpers/firebsaeuploadhelper.dart';
import '../../common/uihelper/snakbar_helper.dart';

class LoginsignupViewModel extends BaseViewModel {
  final _sharedpref = locator<SharedprefService>();
  final _fireService = locator<FireService>();
  final _navigationService = locator<NavigationService>();

  // login
  TextEditingController phone = MaskedTextController(mask: '0000-0000000');
  TextEditingController pass = TextEditingController();

  // signup
  TextEditingController name = TextEditingController();
  TextEditingController number = MaskedTextController(mask: '0000-0000000');
  TextEditingController cnic = MaskedTextController(mask: '00000-0000000-0');
  TextEditingController address = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController passs = TextEditingController();
  TextEditingController conpass = TextEditingController();

  String cat = '';

  void provider() {
    cat = 'provider';
    notifyListeners();
  }

  void user() {
    cat = 'user';
    notifyListeners();
  }

  void rider() {
    cat = 'rider';
    notifyListeners();
  }

  Future<void> selectdob(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dob.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      notifyListeners();
    }
  }

  File? image;
  Future<void> pic() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> next(BuildContext context) async {
    if (name.text.isEmpty ||
        number.text.isEmpty ||
        cnic.text.isEmpty ||
        address.text.isEmpty ||
        dob.text.isEmpty) {
      show_snackbar(context, "Fill all fields");
    } else if (number.text.length != 12) {
      show_snackbar(context, "Number is not correct");
    } else if (cnic.text.length != 15) {
      show_snackbar(context, "Enter cnic with dash");
    } else if (cat == '') {
      show_snackbar(context, "Select a Category");
    } else if (image == null) {
      show_snackbar(context, "select Image");
    } else if (passs.text != conpass.text) {
      show_snackbar(context, "password and confirm password do not match");
    } else {
      displayprogress(context);

      String url = await FirebaseHelper.uploadFile(image!, number.text);

      _sharedpref.setString('name', name.text);
      _sharedpref.setString('number', number.text);
      _sharedpref.setString('cnic', cnic.text);
      _sharedpref.setString('address', address.text);
      _sharedpref.setString('dob', dob.text);
      _sharedpref.setString('cat', cat);
      _sharedpref.setString('img', url);

      Future<bool> result = _fireService.messaging.getToken().then((value) {
        _sharedpref.setString('deviceid', value.toString());
        return ApiHelper.registration(
            name.text,
            cnic.text,
            number.text,
            address.text,
            dob.text,
            cat,
            url,
            passs.text,
            value.toString(),
            context);
      });
      _sharedpref.setString("auth", 'true');
      result.then((value) {
        if (value) {
          hideprogress(context);
          showStatusBar();
          if (cat == 'provider') {
            _sharedpref.setString("auth", 'false');
            _navigationService.clearStackAndShow(Routes.riderproviderView);
            _navigationService.replaceWithTransition(const RiderproviderView(),
                routeName: Routes.riderproviderView,
                transitionStyle: Transition.rightToLeft);
          } else if (cat == 'rider') {
            _navigationService.clearStackAndShow(Routes.riderView);
            _navigationService.replaceWithTransition(const RiderView(),
                routeName: Routes.riderView,
                transitionStyle: Transition.rightToLeft);
          } else {
            _navigationService.clearStackAndShow(Routes.homeView);
            _navigationService.replaceWithTransition(const HomeView(),
                routeName: Routes.homeView,
                transitionStyle: Transition.rightToLeft);
          }
        } else {
          hideprogress(context);
          show_snackbar(context, 'try again later');
        }
      });
    }
  }

  void nav(String c) {
    showStatusBar();
    if (c == 'provider') {
      _navigationService.clearStackAndShow(Routes.providerView);
      _navigationService.replaceWithTransition(const ProviderView(),
          routeName: Routes.providerView,
          transitionStyle: Transition.rightToLeft);
    } else if (c == 'user') {
      _navigationService.clearStackAndShow(Routes.homeView);
      _navigationService.replaceWithTransition(const HomeView(),
          routeName: Routes.homeView, transitionStyle: Transition.rightToLeft);
    } else {
      _navigationService.clearStackAndShow(Routes.riderView);
      _navigationService.replaceWithTransition(const RiderView(),
          routeName: Routes.riderView, transitionStyle: Transition.rightToLeft);
    }
  }

  void login(BuildContext context) {
    if (phone.text.isEmpty || pass.text.isEmpty) {
      show_snackbar(context, "enter all fields");
    } else {
      displayprogress(context);
      var result = _fireService.messaging.getToken().then((value) {
        return ApiHelper.login(
            phone.text, pass.text, value.toString(), context);
      });
      result.then((value) {
        if (value.isNotEmpty) {
          String catt = value['cat'] ?? "";
          _sharedpref.setString('name', value['name']);
          _sharedpref.setString('cnic', value['cnic']);
          _sharedpref.setString('number', phone.text);
          _sharedpref.setString('address', value['address']);
          _sharedpref.setString('dob', value['dob']);
          _sharedpref.setString('cat', catt);
          _sharedpref.setString('img', value['img']);
          _sharedpref.setString('deviceid', value['img']);

          _sharedpref.setString("auth", 'true');
          hideprogress(context);

          nav(catt);
        }
      });
    }
  }

  int currentindex = 0;
  final List<Tab> tabs = [
    const Tab(
      text: "Login",
    ),
    const Tab(
      text: "Signup",
    ),
  ];

  void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    notifyListeners();
  }

  Future<void> first() async {
    np();
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

  Future<void> np() async {
    await Permission.notification.request();
  }
}
