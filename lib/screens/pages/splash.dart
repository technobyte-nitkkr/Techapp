import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techapp/providers/event_provider.dart';
import 'package:techapp/routes.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controlRoute() {
      // if (FirebaseAuth.instance.currentUser == null) {
      //   return '/google_auth';
      //   // return '/navigation';

      // }
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Code',
      home: AnimatedSplashScreen.withScreenFunction(
        screenFunction: () async {
          await FetchDataProvider.loadCategories();
          await FetchDataProvider.loadEvents();
          await FetchDataProvider.loadEventDescription();
          await FetchDataProvider.loadSponsor();
          if (FirebaseAuth.instance.currentUser != null) {
            await FetchDataProvider.loadMyevents(
                FirebaseAuth.instance.currentUser!.email);
          }
          return Navigation();
        },
        splash: 'assets/images/logo.png',
        splashIconSize: 200,
        backgroundColor: technoBackColor,
        splashTransition: SplashTransition.fadeTransition,
      ),
      initialRoute: controlRoute(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
