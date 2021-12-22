import 'package:flutter/material.dart';
import 'package:techapp/screens/auth/google_login.dart';
import 'package:techapp/screens/pages/about_us.dart';
import 'package:techapp/screens/pages/developers.dart';
import 'package:techapp/screens/pages/my_events.dart';
import 'package:techapp/screens/pages/speakers.dart';
import 'package:techapp/screens/pages/sponsors.dart';
import 'package:techapp/screens/pages/team_altius.dart';
import 'screens/pages/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/google_auth':
        return MaterialPageRoute(builder: (_) => GoogleLoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/my_events':
        return MaterialPageRoute(builder: (_) => MyEvents());
      case '/team_altius':
        return MaterialPageRoute(builder: (_) => TeamAltius());
      case '/about_us':
        return MaterialPageRoute(builder: (_) => AboutUs());
      case '/developers':
        return MaterialPageRoute(builder: (_) => Developers());
      case '/speakers':
        return MaterialPageRoute(builder: (_) => Speakers());
      case '/sponsorship':
        return MaterialPageRoute(builder: (_) => Sponsors());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
