import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'main.dart';
class FirebaseApi{
  final _firebaseMessaging =FirebaseMessaging.instance;


  Future<void> initNotifivations()async{
    ///request permission
    await _firebaseMessaging.requestPermission();
    ///fitch token
    final fCMToken = await _firebaseMessaging.getToken();
    ///Prnt Token
    print('Token:- $fCMToken ----');
    initPushNotifications();

  }
  ///Handling Notification message
  void handelMessage(RemoteMessage? message){
    if (message == null )return;
      navigatorKey.currentState?.pushNamed(
        '/Notification_screen',
        arguments:message,
      );
  }

  Future<void> initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handelMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handelMessage);
  }

}