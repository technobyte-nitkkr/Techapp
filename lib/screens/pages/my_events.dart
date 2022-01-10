import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:techapp/widgets/my_event_list.dart';

class MyEvents extends StatelessWidget {
  MyEvents({
    Key? key,
  }) : super(key: key);

  final _trackingScrollController = TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: Column(
        children: [
          Scrollbar(
            controller: _trackingScrollController,
            isAlwaysShown: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _trackingScrollController,
              dragStartBehavior: DragStartBehavior.start,
              child: Text("My Events", style: Pagelabel),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: MyEventList(),
          ),
        ],
      ),
    );
  }
}
