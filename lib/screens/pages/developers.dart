// @dart=2.9
import 'package:flutter/material.dart';
import 'package:techapp/widgets/Animated_Developer.dart';
import 'package:techapp/screens/components/style.dart';

class Developers extends StatelessWidget {
  Developers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: new AppBar(
          title: Text(
            'Developers',
            style: h2s,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: white),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: AnimatedDeveloper(),
    );
  }
}
