import 'package:flutter/material.dart';
import 'package:techapp/utils/colors.dart';

class Sponsors extends StatefulWidget {
  const Sponsors({Key? key}) : super(key: key);

  @override
  _SponsorsState createState() => _SponsorsState();
}

class _SponsorsState extends State<Sponsors> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: grey,
      body: Center(
        child: Text(
          "Sponsors",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
      ),
    );
  }
}