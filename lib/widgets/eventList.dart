import 'package:flutter/material.dart';
import 'package:techapp/providers/event_provider.dart';
import 'package:techapp/widgets/eventListItem.dart';

class EventsByCategoryWidget extends StatelessWidget {
  final String categoryName;

  const EventsByCategoryWidget({Key? key, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final fetchData = Provider.of<FetchDataProvider>(context);
    final eventsMap = FetchDataProvider.eventsMap;

    if (FetchDataProvider.loading)
      return Center(
        child: CircularProgressIndicator(),
      );
    else {
      final eventsKeys = eventsMap[categoryName]!.keys.toList();
      return Flexible(
        // height: MediaQuery.of(context).size.height * 0.4,
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
