import 'package:flutter/material.dart';
import 'package:techapp/utils/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: grey,
      body: Center(
        child: Text(
          "Home",
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