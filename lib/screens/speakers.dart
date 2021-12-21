import 'package:flutter/material.dart';
import 'package:techapp/utils/colors.dart';

class Speakers extends StatefulWidget {
  const Speakers({Key? key}) : super(key: key);

  @override
  _SpeakersState createState() => _SpeakersState();
}

class _SpeakersState extends State<Speakers> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: grey,
      body: Center(
        child: Text(
          "Speakers",
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