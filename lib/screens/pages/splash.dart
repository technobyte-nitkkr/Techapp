// @dart=2.9
import 'dart:typed_data';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:techapp/main.dart';
import 'package:techapp/providers/event_provider.dart';
import 'package:techapp/providers/notification_data_local.dart';
import 'package:techapp/routes.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/navigation.dart';
import 'package:http/http.dart' as http;

Future<Uint8List> _getByteArrayFromUrl(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final user = FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser.displayName
      : " Dummy user";
  void initState() {
    super.initState();

    // forground notification
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        print("message when app is in foreground");
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification.android;

        if (notification != null) {
          await NotificationsProvider.addItem(
              message.notification.title, message.notification.body,
              image: message.notification.android.imageUrl,
              link: message.notification.android.link);
          FetchDataProvider.notification = true;
        }
        if (notification != null && android != null) {
          // ignore: avoid_init_to_null
          ByteArrayAndroidBitmap _bigPicture = null;
          if (android.imageUrl != null) {
            _bigPicture = ByteArrayAndroidBitmap(
                await _getByteArrayFromUrl(android.imageUrl));
          }
          var _styleinformation = android.imageUrl != null
              ? BigPictureStyleInformation(
                  _bigPicture,
                  largeIcon: _bigPicture,
                  contentTitle: notification.title,
                  summaryText: notification.body,
                )
              : BigTextStyleInformation(
                  notification.body,
                  contentTitle: notification.title,
                );
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            "Hello $user!!! " + notification.title,
            "Hello $user!!! " + notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                  styleInformation: _styleinformation),
            ),
          );
        }
      },
    );

    // one message background open event
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      await NotificationsProvider.addItem(
          message.notification.title, message.notification.body,
          image: message.notification.android.imageUrl,
          link: message.notification.android.link);

      Navigator.pushNamed(context, "/notification");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Code',
      home: AnimatedSplashScreen.withScreenFunction(
        splashIconSize: MediaQuery.of(context).size.height,
        screenFunction: () async {
          await FetchDataProvider.loadCategories();
          await FetchDataProvider.loadEvents();
          await FetchDataProvider.loadEventDescription();
          await FetchDataProvider.loadSponsor();

          if (FirebaseAuth.instance.currentUser != null) {
            await FetchDataProvider.loadMyevents(
                FirebaseAuth.instance.currentUser.email);
          }
          FetchDataProvider.notification =
              await NotificationsProvider.checkNoti();
          return Navigation();
        },
        curve: Curves.easeInOut,
        splash: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: technoBackColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Flexible(
                  child: CircularProgressIndicator(
                color: white,
              ))
            ],
          ),
        ),
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
