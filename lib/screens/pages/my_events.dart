import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/widgets/my_event_list.dart';

class MyEvents extends StatelessWidget {
  MyEvents({
    Key? key,
  }) : super(key: key);

  final _trackingScrollController = TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Scrollbar(
                controller: _trackingScrollController,
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _trackingScrollController,
                  dragStartBehavior: DragStartBehavior.start,
                  child: Text(
                    "My Events",
                    style: TextStyle(
                      color: white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: MyEventList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
