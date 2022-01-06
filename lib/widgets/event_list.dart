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
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
      future: client.getEvents(categoryName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            final errormessage =
                json.decode((snapshot.error as DioError).response.toString());

            return Center(
              child: Text(
                errormessage['message'] ?? "Error",
                style: TextStyle(color: white, fontSize: 20),
              ),
            );
          } else {
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
          }
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child:
                  LoadingAnimationWidget.dotsTriangle(color: white, size: 100),
            ),
          );
        }
      },
    );
  }
}
