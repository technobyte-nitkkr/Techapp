// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techapp/providers/event_provider.dart';
import 'package:techapp/routes.dart';
import 'package:techapp/screens/pages/splash.dart';

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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  controlRoute() {
    // if (FirebaseAuth.instance.currentUser == null) {
    //   return '/google_auth';
    //   // return '/navigation';

    // }
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
