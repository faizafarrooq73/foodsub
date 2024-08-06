// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../app/app.locator.dart';
import '../../../services/fire_service.dart';

class FirebaseHelper {
  static Future<String> uploadFile(File? file, String phone) async {
    final fireService = locator<FireService>();

    String filename = path.basename(file!.path);
    String extension = path.extension(file.path);
    String randomChars = DateTime.now().millisecondsSinceEpoch.toString();
    String uniqueFilename = '$filename-$randomChars$extension';

    UploadTask uploadTask = fireService.storage
        .child('user')
        .child(phone)
        .child(uniqueFilename)
        .putFile(file);
    await uploadTask;
    String downloadURL = await fireService.storage
        .child('user')
        .child(phone)
        .child(uniqueFilename)
        .getDownloadURL();
    return downloadURL;
  }

  static Future<void> sendnotificationto(
      String notificationid, String title, String body) async {
    String keys =
        'AAAApWcuIpE:APA91bFFWwviRWyzSz2Pa0nKJ-dJHoe7DkcRii4Csrymuvjc4x7dgaJzyPvswYxk68fO53OhRdrSrjFu79by0WeCUqtKCxvlVHHq2VzNZg9cRl56URq_UIpRUQT8uARpg2r1JtbQlUGH';
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode({
          'to': notificationid,
          'priority': 'high',
          'notification': {'title': title, 'body': body}
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$keys'
        });
  }
}
