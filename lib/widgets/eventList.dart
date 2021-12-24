import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:techapp/providers/event_provider.dart';
import 'package:techapp/widgets/eventListItem.dart';

class EventsByCategoryWidget extends StatelessWidget {
  final String categoryName;
  final String categoryImage;

  const EventsByCategoryWidget(
      {Key? key, required this.categoryName, required this.categoryImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventsMap = Provider.of<FetchDataProvider>(context).eventsMap;
    final eventsKeys = eventsMap[categoryName]!.keys.toList();
    if (eventsMap[categoryName] == null)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return Flexible(
        // height: MediaQuery.of(context).size.height * 0.4,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: eventsMap[categoryName]!.length,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return ListItem(
                eventName:
                    eventsMap[categoryName]![eventsKeys[index]]!.eventName,
                eventCategory: categoryName,
                categoryImage: categoryImage);
          },
        ),
      );
  }
}
