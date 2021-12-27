import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:techapp/providers/event_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';

class TeamAltius extends StatelessWidget {
  TeamAltius({
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
                        "Team Altius",
                        style: TextStyle(
                          color: black,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
              ElevatedButton(
                  onPressed: () {
                    print(FetchDataProvider.contacts);
                  },
                  child: Text('Pressme')),
            ],
          ),
        ),
      ),
    );
  }
}
