// @dart=2.9
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/models/categories.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/widgets/event_list_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techapp/widgets/shimmeritem.dart';

class EventsByCategoryWidget extends StatelessWidget {
  final CategorySchema categoryName;

  const EventsByCategoryWidget({Key key, this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = ApiClient.create();
    return FutureBuilder(
      future: client.getEvents(categoryName.categoryName),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final errormessage = (snapshot.error as DioError).error.toString();
          debugPrint(errormessage);
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
                // return ShimmerItem();
              },
            ),
          );
        } else {
          return ShimmerBuilder(
            title: true,
            subtitle: true,
            imageheight: 100,
          );
        }
      },
    );
  }
}
