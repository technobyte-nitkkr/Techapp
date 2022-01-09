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
        size: 30,
        color:
            (index == 0) ? Colors.purple[800] : Colors.black.withOpacity(0.5),
      ),
      FaIcon(
        FontAwesomeIcons.home,
        size: 30,
        color:
            (index == 1) ? Colors.purple[800] : Colors.black.withOpacity(0.5),
      ),
      FaIcon(
        FontAwesomeIcons.laptopCode,
        size: 30,
        color:
            (index == 2) ? Colors.purple[800] : Colors.black.withOpacity(0.5),
      ),
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
              .copyWith(iconTheme: const IconThemeData(color: black)),
          child: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: white,
            height: 50,
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
