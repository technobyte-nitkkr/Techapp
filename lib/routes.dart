import 'package:flutter/material.dart';
import 'package:techapp/screens/auth/google_login.dart';
import 'package:techapp/screens/pages/about_us.dart';
import 'package:techapp/screens/pages/developers.dart';
import 'package:techapp/screens/pages/my_events.dart';
import 'package:techapp/screens/pages/navigation.dart';
import 'package:techapp/screens/pages/team_altius.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/google_auth':
        return MaterialPageRoute(builder: (_) => GoogleLoginScreen());
      case '/my_events':
        return MaterialPageRoute(builder: (_) => MyEvents());
      case '/team_altius':
        return MaterialPageRoute(builder: (_) => TeamAltius());
      case '/about_us':
        return MaterialPageRoute(builder: (_) => AboutUs());
      case '/developers':
        return MaterialPageRoute(builder: (_) => Developers());
      case '/navigation':
        return MaterialPageRoute(builder: (_) => Navigation());
      default:
        return MaterialPageRoute(builder: (_) => Navigation());

      // return _errorRoute();
    }
  }
}
