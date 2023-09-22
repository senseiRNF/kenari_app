import 'package:firebase_messaging/firebase_messaging.dart';

Future handleBackgroundMessage(RemoteMessage message) async {
  if(message.notification != null) {
    print('Title: ${message.notification!.title}');
    print('Body: ${message.notification!.body}');
  }

  print('Payload: ${message.data}');
}

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();
    
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}