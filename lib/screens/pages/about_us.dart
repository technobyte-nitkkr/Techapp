import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';

class AboutUs extends StatelessWidget {
  AboutUs({
    Key? key,
  }) : super(key: key);

  final _trackingScrollController = TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: SafeArea(child: Text("helloworld")),
    );
  }
}
