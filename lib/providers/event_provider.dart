import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:techapp/models/EventByCategories.dart';
import 'package:http/http.dart' as http;

class FetchDataProvider with ChangeNotifier {
  Map<String, Map<String, Event>> eventsMap = new Map();
  bool loading = false;

  List<String> _categories = [
    "Astronomy",
    "Design",
    "Informals",
    "Managerial",
    "Online-Events",
    "Papyrus-Vitae",
    "Programming",
    "Quizzes",
    "Robotics"
  ];

  FetchDataProvider() {
    initialize();
    print('we have been initialized ');
  }

  Future<void> initialize() async {
    await getDataFromInternet();
  }

  getDataFromInternet() async {
    loading = true;
    print('we have been called from ctr -------2');

    for (int i = 0; i < _categories.length; i++) {
      final url =
          'https://us-central1-techspardha-87928.cloudfunctions.net/api/events/description?eventCategory=${_categories[i]}';
      print(url);
      final response = await http.get(Uri.parse(url));
      // print(url);
      // print(response.body);
      final data = json.decode(response.body);
      final events = data['data']['events'];
      // print(events);

      List<Event> eventList =
          events.map<Event>((json) => Event.fromJson(json)).toList();

      eventList.forEach((element) {
        eventsMap[_categories[i]] = {element.eventName: element};
      });
    }
    loading = false;

    notifyListeners();
  }
}
