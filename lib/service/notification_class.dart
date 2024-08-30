import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage remoteMessage) async{
  print('Title: ${remoteMessage.notification?.title}');
  print('Body: ${remoteMessage.notification?.body}');
  print('Payload: ${remoteMessage.data}');
}
class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;
  final fcm = "fiMZ-TJeTWKCatcqbcvzBC:APA91bFj7OIfmrpld2FfSWnE_2ObRT3BOgQ5kIvTCJK4yCMJHCSRoQcDl_t1xf03nMYsZdeyyNgTZf6rHobqjLhvfw5w7EzKcgiKTasI7OnlfKz9GkHNoe7HagCBblQmeDfwjVZQJfdu";
  Future<void> initNotification()
  async{
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print('Token: $fcmToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}