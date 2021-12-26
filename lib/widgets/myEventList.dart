import 'package:flutter/material.dart';
import 'package:techapp/providers/event_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/widgets/eventListItem.dart';

class MyEventList extends StatelessWidget {
  const MyEventList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FetchDataProvider.myEvents.isEmpty) {
      return Column(
        children: [
          Flexible(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "you have not registered for any events",
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(
            flex: 5,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: FetchDataProvider.myEvents.length,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return ListItem(
                  eventName: FetchDataProvider.myEvents[index].eventName,
                  eventCategory:
                      FetchDataProvider.myEvents[index].eventCategory,
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
