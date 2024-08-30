import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart%20%20';

class PushNotifications {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future<void> init() async {
    await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
        criticalAlert: true,
        announcement: true,
        carPlay: false);
    final token = await _firebaseMessaging.getToken();
    print('Token: $token');
  }
  //
  // static Future initLocalNotification() async {
  //   final AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   //final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
  //   final DarwinInitializationSettings initializationSettingsDarwin =
  //       DarwinInitializationSettings(onDidReceiveLocalNotification: (id, title, body, payload)=>null,);
  //   final LinuxInitializationSettings initializationSettingsLinux =
  //       LinuxInitializationSettings(defaultActionName: 'open notification');
  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(
  //           android: initializationSettingsAndroid, iOS: null, macOS: null);
  //   _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
  //   await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }
}
