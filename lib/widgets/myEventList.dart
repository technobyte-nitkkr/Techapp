import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techapp/models/EventByCategories.dart';
import 'package:techapp/widgets/eventListItem.dart';

class MyEventList extends StatefulWidget {
  @override
  State<MyEventList> createState() => _MyEventListState();
}

class _MyEventListState extends State<MyEventList> {
  List<Event> _myEvents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  dispose() {
    super.dispose();
  }

  loadData() async {
    _isLoading = true;
    // await Future.delayed(Duration(seconds: 2));
    final url =
        'https://us-central1-techspardha-87928.cloudfunctions.net/api/user/eventApp?email=chetan335001@gmail.com';
    final response = await http.get(Uri.parse(url));
    // print(url);
    // print(response.body);
    final data = json.decode(response.body);
    final events = data['data']['events'];
    print(events);
    final eventList =
        events.map<Event>((json) => Event.fromJson(json)).toList();
    _myEvents = eventList;

    _isLoading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading)
      return Flexible(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    else {
      return Expanded(
        flex: 5,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _myEvents.length,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return ListItem(
              eventName: _myEvents[index].eventName,
              eventCategory: _myEvents[index].eventCategory,
            );
          },
        ),
      );
    }
  }
}
