// @dart=2.9
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/widgets/event_list_item.dart';

class MyEventList extends StatelessWidget {
  const MyEventList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));

    return FutureBuilder(
      future: client.getMyEvents(FetchDataProvider.user.email),
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
            List<Event> events = snapshot.data.getMyEvents();
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: events.length,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return ListItem(
                  item: events[index],
                );
              },
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
