import 'dart:typed_data';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:techapp/main.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/providers/local_storage_provider.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/error_page.dart';
import 'package:techapp/screens/pages/navigation.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

Future<Uint8List> _getByteArrayFromUrl(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final user = FetchDataProvider.user != null
      ? FetchDataProvider.user?.name
      : " Dummy user";
  void initState() {
    super.initState();

    // forground notification
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        debugPrint("message when app is in foreground");
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null) {
          await NotificationsProvider.addItem(
              message.notification!.title!, message.notification!.body!,
              image: message.notification!.android!.imageUrl ?? '',
              link: message.notification!.android!.link ?? '');
        }
        if (notification != null && android != null) {
          // ignore: avoid_init_to_null
          ByteArrayAndroidBitmap? _bigPicture = null;
          if (android.imageUrl != null) {
            _bigPicture = ByteArrayAndroidBitmap(
                await _getByteArrayFromUrl(android.imageUrl!));
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
      },
    );

    // one message background open event
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint('A new onMessageOpenedApp event was published!');
      // ignore: unnecessary_null_comparison
      if (message != null && message.notification != null) {
        await NotificationsProvider.addItem(
            message.notification!.title ?? '', message.notification!.body ?? '',
            image: message.notification!.android?.imageUrl ?? '',
            link: message.notification!.android?.link ?? '');
      }
      Navigator.pushNamed(context, "/notification");
    });
  }

  Future<dynamic> loadDataDuringSplash(BuildContext context) async {
    final client = ApiClient.create();
    FetchDataProvider.notification = await NotificationsProvider.checkNoti();
    await FetchDataProvider.loadProfileOnline();
    var data = await client.getAllEvents();
    data.getAllEvents();
    var data2 = await client.getCategories();
    FetchDataProvider.categories = data2.getCategories();
    data = await client.getSponsors();
    FetchDataProvider.sponsors = data.getFoodSponsors();
    data = await client.getLectures();
    FetchDataProvider.speakers = data.getLectures();

    try {
      if (FetchDataProvider.user != null) {
        data = await client.getMyEvents(FetchDataProvider.jwt);
        data.getMyEvents();
      }
      if (FirebaseAuth.instance.currentUser == null) {
        return await Navigator.pushNamedAndRemoveUntil(
            context, '/google_auth', (route) => false);
      }
    } catch (e) {
      debugPrint(e.toString());
      FetchDataProvider.myEvents = [];
    }
    FirebaseMessaging.instance.subscribeToTopic("allNoti");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Techspardha',
      home: AnimatedSplashScreen.withScreenFunction(
        splashIconSize: MediaQuery.of(context).size.height,
        screenFunction: () async {
          try {
            await loadDataDuringSplash(context);
          } on DioError catch (e) {
            final errormessage = e.error.toString();
            return await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => ErrorPagge(
                    message: errormessage,
                  ),
                ),
                (route) => false);
          }
          return await Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Navigation()));
        },
        curve: Curves.easeInOut,
        splash: SplashAnimation(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 4,
      ),
    );
  }
}

class SplashAnimation extends StatelessWidget {
  const SplashAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage("assets/images/video.gif"),
                fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "TECHSPARDHA",
                style: h1s.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "UNRAVELLING DIMENSIONS",
                style: h1s.copyWith(
                  fontSize: 18,
                  fontFamily: 'glitch',
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  AutoSizeText(
                    'Made with  ',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: white, fontSize: 15),
                  ),
                  FaIcon(
                    FontAwesomeIcons.solidHeart,
                    size: 15,
                    color: white,
                  ),
                  AutoSizeText(
                    ' by Technobyte ',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: white, fontSize: 15),
                  )
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
