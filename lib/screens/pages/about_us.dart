import 'package:flutter/material.dart';
import 'package:techapp/providers/event_provider.dart';

import 'package:techapp/screens/layouts/page_layout.dart';

class AboutUs extends StatelessWidget {
  AboutUs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: SafeArea(child:
      Text('hello')),
    );
  }
}
