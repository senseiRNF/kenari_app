import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kenari_app/services/local/local_notification_services.dart';

@pragma('vm:entry-point')
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
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        LocalNotificationServices.initLocalNotificationPlugin().then((flutterLocalNotificationsPlugin) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                LocalNotificationServices.channel.id,
                LocalNotificationServices.channel.name,
                channelDescription: LocalNotificationServices.channel.description,
                icon: android.smallIcon,
                // other properties...
              ),
            ),
          );
        });
      }
    });
  }
}