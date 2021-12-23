import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:techapp/models/EventByCategories.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:techapp/widgets/eventListItem.dart';

class EventsByCategoryWidget extends StatefulWidget {
  final String categoryName;
  final String categoryImage;

  const EventsByCategoryWidget(
      {Key? key, required this.categoryName, required this.categoryImage})
      : super(key: key);

  @override
  State<EventsByCategoryWidget> createState() => _EventsByCategoryWidgetState();
}

class _EventsByCategoryWidgetState extends State<EventsByCategoryWidget> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    // await Future.delayed(Duration(seconds: 2));
    final url =
        'https://us-central1-techspardha-87928.cloudfunctions.net/api/events/description?eventCategory=${widget.categoryName}';
    final response = await http.get(Uri.parse(url));
    // print(url);
    // print(response.body);
    final data = json.decode(response.body);
    final events = data['data']['events'];
    // print(events);

    EventList.events =
        events.map<Event>((json) => Event.fromJson(json)).toList();

    setState(() {});
  }

  @override
  void dispose() {
    EventList.events = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (EventList.events.length == 0)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return Flexible(
        // height: MediaQuery.of(context).size.height * 0.4,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: EventList.events.length,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return ListItem(
                  item: EventList.events[index],
                  categoryImage: widget.categoryImage);
            }),
      );
  }
}
