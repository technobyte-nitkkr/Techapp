// @dart=2.9
// ignore: unused_import
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:techapp/providers/local_storage_provider.dart';
import 'package:techapp/routes.dart';

// creating the android channel
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'technobyte', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
  playSound: true,
);

// flutter local notication intialisation
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// background handler for firebase messaging
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  // save notication to local storage
  if (message.notification != null) {
    await NotificationsProvider.addItem(
        message.notification.title, message.notification.body,
        image: message.notification.android.imageUrl,
        link: message.notification.android.link);
  }

  debugPrint('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // lock the orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  // force dark theme
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: Brightness.light));

  // initialise the firebase
  await Firebase.initializeApp();

  // firebase background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // initial notificaton channel
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // background message option
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // subscribe to notificatinon chanel

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  controlRoute() {
    // if user not login then redirect to auth
    if (FirebaseAuth.instance.currentUser == null) {
      return '/google_auth';
    }
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
