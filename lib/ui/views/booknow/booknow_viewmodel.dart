import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:food_sub/ui/common/apihelpers/apihelper.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/sharedpref_service.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../chat/chating/chating_view.dart';

class BooknowViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final sharedpref = locator<SharedprefService>();

  String val = "new";

  Future<void> changereststatus(BuildContext context, String id) async {
    await ApiHelper.updatereststatus(id, "old", context);
    notifyListeners();
  }

  StreamSubscription<Position>? positionStream;
  Future<void> changeriderstatus(
      BuildContext context, String id, Map data) async {
    displayprogress(context);
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      timeLimit: const Duration(seconds: 5),
      forceAndroidLocationManager: true,
    );
    double latitude = position.latitude;
    double longitude = position.longitude;
    await ApiHelper.updateriderstatus(id, latitude.toString(),
        longitude.toString(), sharedpref.readString('number'), context);
    notifyListeners();

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: calculateDistance(
          double.parse(data['ulat'].toString()),
          double.parse(data['ulon'].toString()),
          double.parse(data['clat'].toString()),
          double.parse(data['clon'].toString())),
    );
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) async {
      if (position != null) {
        await ApiHelper.updateloc(id, position.latitude.toString(),
            position.longitude.toString(), context);
        notifyListeners();
      }
    });
  }

  int calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371e3;

    double lat1Radians = degToRad(lat1);
    double lat2Radians = degToRad(lat2);
    double dLat = lat2Radians - lat1Radians;
    double dLon = degToRad(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Radians) * cos(lat2Radians) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double result = earthRadius * c;
    return result.toInt();
  }

  double degToRad(double deg) {
    return deg * (pi / 180);
  }

  Future<void> changestatus(BuildContext context, String id) async {
    positionStream?.cancel();
    await ApiHelper.doneorder(id, context);
    notifyListeners();
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        String address =
            '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
        return address;
      } else {
        return "Failed to get address";
      }
    } catch (e) {
      return "Failed to get address";
    }
  }

  String addDays(String dateString, int days) {
    final DateTime parsedDate = DateTime.parse(dateString);
    final DateTime futureDate = parsedDate.add(Duration(days: days));
    return DateFormat('yyyy-MM-dd').format(futureDate);
  }

  bool isFutureDate(String dateString, int days) {
    final String futureDateString = addDays(dateString, days);
    final DateTime futureDate = DateTime.parse(futureDateString);
    final DateTime currentDate = DateTime.now();
    return futureDate.isAfter(currentDate);
  }

  Future<void> chat(String uid, String number) async {
    Map c = await ApiHelper.registerchat(uid, number);
    if (c['status']) {
      _navigationService.navigateWithTransition(
          ChatingView(
            id: c['message'],
            did: c['did'],
          ),
          routeName: Routes.chatingView,
          transitionStyle: Transition.rightToLeft);
    }
  }
}
