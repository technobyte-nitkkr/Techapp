import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techapp/routes.dart';
import 'package:techapp/screens/auth/firebase_services.dart';
import '../controllers/MenuController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    controlRoute() {
      if (FirebaseAuth.instance.currentUser == null) {
        return '/google_auth';
      } else {
        return '/home';
      }
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'techapp',
        initialRoute: controlRoute(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
