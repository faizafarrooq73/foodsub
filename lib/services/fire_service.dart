import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireService {
  Reference storage = FirebaseStorage.instance.ref();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
}
