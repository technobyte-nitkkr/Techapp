import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_earth_globe/flutter_earth_globe.dart';
import 'package:flutter_earth_globe/flutter_earth_globe_controller.dart';
import 'package:flutter_earth_globe/sphere_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techapp/main.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/providers/local_storage_provider.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/error_page.dart';
import 'package:techapp/screens/pages/navigation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();

    // forground notification

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('A new onMessage event was published!');
      showFlutterNotification(message);
    });

    // one message background open event
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(context, "/notification");
    });
  }

  Future<dynamic> loadDataDuringSplash(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await NotificationsProvider.addItem(initialMessage.notification!.title!,
          initialMessage.notification!.body!,
          image: initialMessage.notification!.android!.imageUrl!,
          link: initialMessage.notification!.android!.link!);
    }
    final client = ApiClient.create();
    FetchDataProvider.notification = await NotificationsProvider.checkNoti();
    await FetchDataProvider.loadProfileOnline();
    var data = await client.getAllEvents();
    // Logger().i(data);
    data.getAllEvents();
    var data2 = await client.getCategories();
    FetchDataProvider.categories = data2.getCategories();
    data = await client.getSponsors();
    FetchDataProvider.sponsors = data.getFoodSponsors();
    data = await client.getLectures();
    FetchDataProvider.speakers = data.getLectures();

    try {
      if (FetchDataProvider.user != null && FetchDataProvider.jwt != null) {
        data = await client.getMyEvents(FetchDataProvider.jwt!);
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
          } on DioException catch (e) {
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

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({Key? key}) : super(key: key);

  @override
  _SplashAnimationState createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation> {
  final FlutterEarthGlobeController _controller = FlutterEarthGlobeController(
      rotationSpeed: 0.1,
      // isRotating: true,
      sphereStyle: (SphereStyle(
          shadowColor: Colors.orange.withOpacity(0.8), shadowBlurSigma: 20)),
      isBackgroundFollowingSphereRotation: true,
      background: Image.asset('assets/images/background.jpg').image,
      surface: Image.asset('assets/images/Planet_2.png').image);

  @override
  void initState() {
    _controller.onLoaded = () {
      _controller.startRotation();
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (_controller.isRotating == false) {
    //   _controller.startRotation();
    // }
    return Stack(
      children: [
        // SafeArea(
        //     child: FlutterEarthGlobe(
        //   controller: _controller,

        //   // alignment: Alignment.bottomCenter,
        //   radius: 80,
        // )),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 0, 25, 38),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/NewBg.png"))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "TECHSPARDHA",
                  style: h1s.copyWith(
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'RubikWetPaint',
                    color: white,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: const Color.fromRGBO(59, 130, 246, 1),
                        offset: const Offset(-2, 0),
                      ),
                      Shadow(
                        blurRadius: 4.0,
                        color: const Color.fromRGBO(59, 130, 246, 1),
                        offset: const Offset(2, 0),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Frontier Reimagined",
                  style: h1s.copyWith(
                    fontSize: 24,
                    fontFamily: 'Satoshi',
                    // add shadows

                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // Wrap the image with AnimatedBuilder for continuous rotation

                SizedBox(
                  height: 200,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                    ],
                  ),
                ),
                SizedBox(height: 10),
                LoadingAnimationWidget.staggeredDotsWave(
                  color: white,
                  size: 40,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
