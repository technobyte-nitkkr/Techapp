// @dart=2.9
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/widgets/event_list_item.dart';
import 'package:techapp/screens/widgets/shimmeritem.dart';

class MyEventList extends StatelessWidget {
  const MyEventList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = ApiClient.create();

    return FutureBuilder(
      future: client.getMyEvents(FetchDataProvider.jwt),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final errormessage = (snapshot.error as DioError).error.toString();
          debugPrint(errormessage);
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
              child: Text(
                errormessage ?? "Error",
                style: h1s,
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else if (snapshot.hasData) {
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
        } else {
          return ShimmerBuilder2(
            title: true,
            subtitle: true,
            imageheight: 100,
          );
        }
      },
    );
  }
}
