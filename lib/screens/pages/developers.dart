import 'package:flutter/material.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/screens/widgets/Animated_Developer.dart';
import 'package:techapp/screens/components/style.dart';

class Developers extends StatelessWidget {
  Developers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        child: Column(
      children: [
        Text("Developers", style: Pagelabel),
        AnimatedDeveloper(),
      ],
    ));
  }
}
