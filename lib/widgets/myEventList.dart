import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techapp/models/EventByCategories.dart';
import 'package:techapp/screens/components/style.dart';
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
    if (FirebaseAuth.instance.currentUser != null) {
      // await Future.delayed(Duration(seconds: 2));
      // will change the mail later
      final String? email = FirebaseAuth.instance.currentUser!.email;
      final url =
          'https://us-central1-techspardha-87928.cloudfunctions.net/api/user/eventApp?email=$email';
      final response = await http.get(Uri.parse(url));
      // print(url);
      // print(response.body);
      final data = json.decode(response.body);
      final events = data['data']['events'];
      // print(events);
      final eventList =
          events.map<Event>((json) => Event.fromJson(json)).toList();
      _myEvents = eventList;
    }
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading)
      return Column(
        children: [
          Flexible(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      );
    else if (_myEvents.isEmpty) {
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
          ),
        ],
      );
    }
  }
}
