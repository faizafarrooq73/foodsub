// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../uihelper/snakbar_helper.dart';
import 'firebsaeuploadhelper.dart';
//const url = "https://glitch.com/edit/#!/swanky-fern-daphne";
const url = 'http://10.0.2.2:3000/';
const registrationlink = "${url}register";
const loginlink = "${url}login";
const getoneuserlink = "${url}getoneuser";

// item
const registeritemlink = '${url}registeritem';
const getitemlink = '${url}getitem';
const deleteitemlink = '${url}deleteitem';

// menu
const registermenulink = "${url}registermenu";
const allmenulink = "${url}allmenu";
const updatedmenulink = "${url}updatedmenu";
const deletemenulink = "${url}deletemenu";
const allmenuadminlink = '${url}allmenuadmin';
const allmenuwnlink = '${url}allmenuwn';

// rest
const registerrestlink = '${url}registerrest';
const getrestlink = '${url}getrest';
const updaterestlink = '${url}updaterest';
const getallrestlink = "${url}getallrest";

// order
const registeroderlink = "${url}registeroder";
const getbyrestlink = "${url}getbyrest";
const getbyuserlink = "${url}getbyuser";
const getbyriderlink = "${url}getbyrider";
const updatereststatuslink = "${url}updatereststatus";
const getbyriderstatuslink = "${url}getbyriderstatus";
const updateriderstatuslink = "${url}updateriderstatus";
const doneorderlink = "${url}doneorder";
const updateloclink = "${url}updateloc";

// chat
const registerchatlink = "${url}registerchat";
const allchatbyidlink = "${url}allchatbyid";
const addchatlink = "${url}addchat";
const allchatbydidlink = "${url}allchatbydid";

// promotion
const registerpromotionlink = "${url}registerpromotion";
const allpromotionbynumlink = "${url}allpromotionbynum";
const allpromotionlink = "${url}allpromotion";
const deletepromotionlink = "${url}deletepromotion";
const promotionbycodelink = "${url}promotionbycode";

class ApiHelper {
  // promotion
  static Future<bool> registerpromotion(
      String number, String img, String dis, String date) async {
    try {
      int random = Random().nextInt(100000);
      var response = await http.post(Uri.parse(registerpromotionlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "img": img,
            "dis": dis,
            "code": random.toString(),
            "date": date,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  static Future<List> allpromotionbynum(String number) async {
    try {
      var response = await http.post(Uri.parse(allpromotionbynumlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"number": number}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<List> deletepromotion(String id) async {
    try {
      var response = await http.post(Uri.parse(deletepromotionlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<Map> promotionbycode(String code) async {
    try {
      var response = await http.post(Uri.parse(promotionbycodelink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"code": code}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return {};
    }
  }

  static Future<List> allpromotion() async {
    try {
      var response = await http.post(Uri.parse(allpromotionlink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  // chat
  static Future<Map> registerchat(String uid, String did) async {
    try {
      var response = await http.post(Uri.parse(registerchatlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "uid": uid,
            "did": did,
            "c": [],
            "date": DateTime.now().toString(),
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      return {};
    }
  }

  static Future<Map> allchatbyid(String id) async {
    try {
      var response = await http.post(Uri.parse(allchatbyidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return {};
    }
  }

  static Future<List> allchatbydid(String did) async {
    try {
      var response = await http.post(Uri.parse(allchatbydidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"did": did}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> addchat(String id, Map dataa, String sendto) async {
    try {
      var response = await http.post(Uri.parse(addchatlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id, "data": dataa}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      Map d = await getoneuser(sendto);
      await FirebaseHelper.sendnotificationto(
          d['deviceid'], "New Message", dataa['mess']);
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  // order
  static Future<bool> registeroder(
      String restnumber,
      String custnumber,
      String datetime,
      List menu,
      String clat,
      String clon,
      String ulat,
      String ulon,
      String sechdule,
      String sechduledays,
      String sechduletime,
      String status,
      String dis,
      BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registeroderlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "restnumber": restnumber,
            "ridernumber": "",
            "custnumber": custnumber,
            "datetime": datetime,
            'menu': menu,
            'clat': clat,
            'clon': clon,
            'ulat': ulat,
            'ulon': ulon,
            'status': status,
            'sechdule': sechdule,
            'sechduledays': sechduledays,
            'sechduletime': sechduletime,
            'reststatus': 'new',
            'riderstatus': '',
            'dis': dis
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['sucess']);
      hideprogress(context);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<List> getbyrest(String restnumber) async {
    try {
      var response = await http.post(Uri.parse(getbyrestlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"restnumber": restnumber}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['rest'] as List;
    } catch (e) {
      return [];
    }
  }

  static Future<List> getbyuser(String custnumber) async {
    try {
      var response = await http.post(Uri.parse(getbyuserlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"custnumber": custnumber}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['rest'] as List;
    } catch (e) {
      return [];
    }
  }

  static Future<List> getbyrider(String ridernumber) async {
    try {
      var response = await http.post(Uri.parse(getbyriderlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"ridernumber": ridernumber}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['rest'] as List;
    } catch (e) {
      return [];
    }
  }

  static Future<List> getbyriderstatus() async {
    try {
      var response = await http.post(Uri.parse(getbyriderstatuslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"riderstatus": "new"}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['rest'] as List;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> updatereststatus(
      String id, String reststatus, BuildContext context) async {
    try {
      displayprogress(context);
      var response = await http.post(Uri.parse(updatereststatuslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              {"id": id, "reststatus": reststatus, "riderstatus": "new"}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      hideprogress(context);
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<bool> updateriderstatus(String id, String clat, String clon,
      String ridernumber, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(updateriderstatuslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "status": "delivery",
            "riderstatus": "old",
            "clat": clat,
            "clon": clon,
            "ridernumber": ridernumber
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      hideprogress(context);
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<bool> doneorder(String id, BuildContext context) async {
    try {
      displayprogress(context);
      var response = await http.post(Uri.parse(doneorderlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "status": "old",
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      hideprogress(context);
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<bool> updateloc(
      String id, String clat, String clon, BuildContext context) async {
    try {
      displayprogress(context);
      var response = await http.post(Uri.parse(updateloclink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id, "clat": clat, "clon": clon}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      hideprogress(context);
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  // rest
  static Future<bool> registerrest(String number, String name, String open,
      String close, String image, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registerrestlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "name": name,
            "open": open,
            "close": close,
            'image': image,
            'rating': '1',
            'user': '1',
            'review': [],
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['sucess']);
      hideprogress(context);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<Map> getrest(String number) async {
    try {
      var response = await http.post(Uri.parse(getrestlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"number": number}));
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      return {};
    }
  }

  static Future<Map> getallrest() async {
    try {
      var response = await http.post(Uri.parse(getallrestlink),
          headers: {"Content-Type": "application/json"});
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      return {};
    }
  }

  static Future<bool> updaterest(
      String id,
      String name,
      String open,
      String close,
      String image,
      String rating,
      String user,
      List review,
      BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(updaterestlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "name": name,
            "open": open,
            "close": close,
            'image': image,
            'rating': rating,
            'user': user,
            'review': review,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  // menu
  static Future<bool> menuregistration(
      String number,
      String itemname,
      String itemprice,
      String itemdes,
      String image,
      String cat,
      String type,
      BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registermenulink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "itemname": itemname,
            "number": number,
            "itemprice": itemprice,
            "image": image,
            "itemdes": itemdes,
            'cat': cat,
            "type": type
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<Map> getallmenu(String number, String cat) async {
    try {
      var response = await http.post(Uri.parse(allmenulink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"number": number, "cat": cat}));
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      return {};
    }
  }

  static Future<Map> allmenuadmin(String number) async {
    try {
      var response = await http.post(Uri.parse(allmenuadminlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"number": number}));
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      return {};
    }
  }

  static Future<Map> allmenuwn() async {
    try {
      var response = await http.post(Uri.parse(allmenuwnlink),
          headers: {"Content-Type": "application/json"});
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      return {};
    }
  }

  static Future<bool> updatemenu(
      String id,
      String itemname,
      String itemprice,
      String itemdes,
      String image,
      String cat,
      String type,
      BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(updatedmenulink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "itemname": itemname,
            "id": id,
            "itemprice": itemprice,
            "image": image,
            "itemdes": itemdes,
            'cat': cat,
            "type": type
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['message']);
      return data['status'] as bool;
    } catch (e) {
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<bool> deletemenu(String id, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(deletemenulink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['message']);
      return data['status'] as bool;
    } catch (e) {
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  // item
  static Future<bool> registeritem(
      String name, String number, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registeritemlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"number": number, "name": name}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['success']);
      return data['status'] as bool;
    } catch (e) {
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<List> getitem(String number) async {
    try {
      var response = await http.post(Uri.parse(getitemlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"number": number}));
      return jsonDecode(utf8.decode(response.bodyBytes))['item'] as List;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> deleteitem(String id) async {
    try {
      var response = await http.post(Uri.parse(deleteitemlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      return jsonDecode(utf8.decode(response.bodyBytes))['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  // auth
  static Future<bool> registration(
      String name,
      String cnic,
      String number,
      String address,
      String age,
      String cat,
      String img,
      String pass,
      String deviceid,
      BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registrationlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "name": name,
            "cnic": cnic,
            "number": number,
            "address": address,
            "dob": age,
            "cat": cat,
            "img": img,
            "pass": pass,
            "deviceid": deviceid,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'tryagainlater');
      return false;
    }
  }

  static Future<Map> login(
      String number, String pass, String deviceid, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(loginlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              {"number": number, "pass": pass, "deviceid": deviceid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (data['status']) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(data['token']);
        return decodedToken;
      } else {
        hideprogress(context);
        show_snackbar(context, data['message']);
        return {};
      }
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return {};
    }
  }

  static Future<Map> getoneuser(String id) async {
    try {
      var response = await http.post(Uri.parse(getoneuserlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (data['status']) {
        return data['data'] as Map;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }
}
