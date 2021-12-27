import 'package:flutter/material.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/widgets/eventListItem.dart';

class EventsByCategoryWidget extends StatelessWidget {
  final String categoryName;

  const EventsByCategoryWidget({Key? key, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventsMap = FetchDataProvider.eventsMap;

    if (FetchDataProvider.loading)
      return Center(
        child: CircularProgressIndicator(),
      );
    else {
      final eventsKeys = eventsMap[categoryName]!.keys.toList();
      return Flexible(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: eventsMap[categoryName]!.length,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return ListItem(
              eventName: eventsMap[categoryName]![eventsKeys[index]]!.eventName,
              eventCategory: categoryName,
            );
          },
        ),
      );
    }
  }
}
