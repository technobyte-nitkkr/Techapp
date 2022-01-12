import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/speakers.dart';
import 'package:techapp/screens/pages/sponsors.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'home.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  DateTime pre_backpress = DateTime.now();
  int index = 1;
  @override
  Widget build(BuildContext context) {
    final screens = [
      Sponsors(),
      Home(),
      Speakers(),
    ];

    final items = <Widget>[
      FaIcon(
        FontAwesomeIcons.moneyBill,
        size: 20,
        color: (index == 0)
            ? Colors.black.withOpacity(0.8)
            : Colors.black.withOpacity(0.5),
      ),
      FaIcon(
        FontAwesomeIcons.home,
        size: 20,
        color: (index == 1)
            ? Colors.black.withOpacity(0.8)
            : Colors.black.withOpacity(0.5),
      ),
      Image.asset(
        "assets/images/GL.png",
        color: (index == 2)
            ? Colors.black.withOpacity(0.8)
            : Colors.black.withOpacity(0.5),
        fit: BoxFit.fill,
        height: 22,
        width: 22,
      )
      // FaIcon(
      //   FontAwesomeIcons.laptopCode,
      //   size: 30,
      //   color: (index == 2)
      //       ? Colors.black.withOpacity(0.8)
      //       : Colors.black.withOpacity(0.5),
      // ),
    ];
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          //show snackbar
          final snack = SnackBar(
            backgroundColor: Colors.white24,
            content: Text(
              'Press Back button again to Exit',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Colors.white.withOpacity(0.8),
          height: 40,
          index: index,
          animationDuration: const Duration(milliseconds: 450),
          items: items,
          onTap: (index) => setState(() => this.index = index),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: screens[index],
            ),
          ],
        ),
      ),
    );
  }
}
