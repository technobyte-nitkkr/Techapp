// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techapp/providers/event_provider.dart';
import 'package:techapp/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarBrightness: Brightness.light) // Or Brightness.dark
  );
  await Firebase.initializeApp();
  await FetchDataProvider.loadCategories();
  await FetchDataProvider.loadEvents();
  await FetchDataProvider.loadEventDescription();
  await FetchDataProvider.loadSponsor();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    controlRoute() {
      // if (FirebaseAuth.instance.currentUser == null) {
      //   return '/google_auth';
      //   // return '/navigation';

      // }
    }

    return //MultiProvider(
        MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'techapp',
      initialRoute: controlRoute(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

        // providers: [
        //   ChangeNotifierProvider(
        //     create: (context) => MenuController(),
        //   ),
        //   //ChangeNotifierProvider(create: (_) => FetchDataProvider()),
        // ],