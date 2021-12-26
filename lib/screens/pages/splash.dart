import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techapp/providers/event_provider.dart';
import 'package:techapp/routes.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
                FirebaseAuth.instance.currentUser!.email);
          }
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
