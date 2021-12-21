import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/home.dart';
import 'package:techapp/screens/speakers.dart';
import 'package:techapp/screens/sponsors.dart';
import 'package:techapp/utils/colors.dart';
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
      const Sponsors(),
      const Home(),
      const Speakers(),
    ];

    final items = <Widget>[
      const Icon(Icons.money_rounded, size: 40),
      const Icon(Icons.home, size: 40),
      const Icon(Icons.speaker_group, size: 40),
    ];

    return Scaffold(
      //extendBody: true,
      backgroundColor: grey,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(
          color: grey,
        )),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: white,
          height: 60,
          index: index,
          animationDuration: const Duration(milliseconds: 300),
          items: items,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
      body: screens[index],
      // Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
      // const SizedBox(
      //   height: 20,
      // ),
      // Text("${FirebaseAuth.instance.currentUser!.displayName}"),
      // Text("${FirebaseAuth.instance.currentUser!.email}"),
      // const SizedBox(
      //   height: 20,
      // ),
      // ElevatedButton(
      //   style: ElevatedButton.styleFrom(
      //     primary: white,
      //   ),
      //   child: const Text(
      //     "Logout",
      //     style: TextStyle(color: black),
      //   ),
      //   onPressed: () async {
      //     await FirebaseServices().googleSignOut();
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => const GoogleLoginScreen()));
      //   },
      // ),
    );
  }
}
