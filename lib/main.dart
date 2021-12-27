// @dart=2.9
// ignore: unused_import
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:techapp/providers/notification_data_local.dart';
import 'package:techapp/routes.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'technobyte', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.notification != null) {
    await NotificationsProvider.addItem(
        message.notification.title, message.notification.body,
        image: message.notification.android.imageUrl,
        link: message.notification.android.link);
  }

  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light) // Or Brightness.dark
      );
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.subscribeToTopic("allNoti");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // get the message when user taps

  controlRoute() {
    if (FirebaseAuth.instance.currentUser == null) {
      return '/google_auth';
      // return '/navigation';

    }
    return '/splash';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: controlRoute(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
