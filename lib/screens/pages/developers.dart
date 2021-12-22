import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';

class Developers extends StatelessWidget {
  Developers({
    Key? key,
  }) : super(key: key);

  final _trackingScrollController = TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
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
                    "Developers",
                    style: TextStyle(
                      color: black,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
