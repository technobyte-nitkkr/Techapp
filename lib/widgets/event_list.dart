// @dart=2.9
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/widgets/event_list_item.dart';

class EventsByCategoryWidget extends StatelessWidget {
  final String categoryName;

  const EventsByCategoryWidget({Key key, this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = ApiClient.create();
    return FutureBuilder(
      future: client.getEvents(categoryName),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final errormessage = (snapshot.error as DioError).error.toString();
          print(errormessage);
          return Center(
            child: Text(
              errormessage ?? "Error",
              style: h1s,
            ),
          );
        } else if (snapshot.hasData) {
          List<Event> events = snapshot.data.getEventList();
          return Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return ListItem(
                  item: events[index],
                );
              },
            ),
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child:
                  LoadingAnimationWidget.dotsTriangle(color: white, size: 200),
            ),
          );
        }
      },
    );
  }
}
