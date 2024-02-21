// ignore: unused_import
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:techapp/models/user.dart';
import 'package:techapp/providers/local_storage_provider.dart';
import 'package:techapp/routes.dart';
import 'package:http/http.dart' as http;

// background handler for firebase messaging
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

Future<Uint8List> _getByteArrayFromUrl(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}

// creating the android channel
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  channel = const AndroidNotificationChannel(
    'technobyte', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) async {
  final userDetails = await NotificationsProvider.getUser();
  Logger().d(userDetails);
  final user = userDetails != null
      ? UserDetails.fromJson(userDetails).name
      : "Technobyte User";
  if (message.notification != null) {
    await NotificationsProvider.addItem(
        message.notification!.title!, message.notification!.body!,
        image: message.notification!.android!.imageUrl!,
        link: message.notification!.android!.link!);
  }
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    // ignore: avoid_init_to_null
    ByteArrayAndroidBitmap? _bigPicture = null;
    if (android.imageUrl != null) {
      _bigPicture =
          ByteArrayAndroidBitmap(await _getByteArrayFromUrl(android.imageUrl!));
    }

    // if image url present then donwload image
    var _styleinformation = android.imageUrl != null
        ? BigPictureStyleInformation(
            _bigPicture!,
            largeIcon: _bigPicture,
            contentTitle: notification.title,
            summaryText: notification.body,
          )
        : BigTextStyleInformation(
            notification.body ?? '',
            contentTitle: notification.title,
          );
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      "Hello $user!!! " + notification.title!,
      "Hello $user!!! " + notification.body!,
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
            styleInformation: _styleinformation),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  // force dark theme
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  Permission.notification.isDenied.then((value) {
    Logger().d("permission denied");
    Logger().d(value);
    if (value) {
      Permission.notification.request();
    }
  });
  // firebase background handler
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();

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
