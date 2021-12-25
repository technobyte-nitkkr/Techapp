import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/speakers.dart';
import 'package:techapp/screens/pages/sponsors.dart';

import 'home.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    final screens = [
      Sponsors(),
      Home(),
      Speakers(),
    ];

    DateTime pre_backpress = DateTime.now();
    final items = <Widget>[
      const Icon(Icons.money_rounded, size: 30),
      const Icon(Icons.home, size: 30),
      const Icon(Icons.speaker_group, size: 30),
    ];
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          //show snackbar
          final snack = SnackBar(
            backgroundColor: gradientEndColor2,
            content: Text('Press Back button again to Exit'),
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
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: const IconThemeData(color: white)),
          child: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: navigationColor,
            height: 45,
            index: index,
            animationDuration: const Duration(milliseconds: 450),
            items: items,
            onTap: (index) => setState(() => this.index = index),
            animationCurve: Curves.easeInOut,
          ),
        ),
        body: screens[index],
      ),
    );
  }
}
