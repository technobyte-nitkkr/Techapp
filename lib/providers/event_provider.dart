import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:techapp/models/EventByCategories.dart';
import 'package:http/http.dart' as http;
import 'package:techapp/models/eventAll.dart';

class FetchDataProvider with ChangeNotifier {
  // event map first key refer for category and second key refer to event name
  Map<String, Map<String, Event>> eventsMap = new Map();

  bool loading = false;

  // list of all categories
  List<String> categories = [];
  // list of all events
  List<AllEvents> allEvents = [];

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
    await loadCategories();
    await loadEvents();
    await loadEventDescription();

    loading = false;

    notifyListeners();
  }

  Future<void> loadCategories() async {
    final url =
        'https://us-central1-techspardha-87928.cloudfunctions.net/api/events/categories';
    print(url);
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    final categoriesjson = data['data']['categories'];
    categories = categoriesjson.map<String>((e) => e.toString()).toList();
    // print(categoriesjson);
  }

  Future<void> loadEvents() async {
    final url =
        'https://us-central1-techspardha-87928.cloudfunctions.net/api/events';
    print(url);
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    final events = data['data']['events'];
    allEvents =
        events.map<AllEvents>((json) => AllEvents.fromJson(json)).toList();
  }

  Future<void> loadEventDescription() async {
    for (int i = 0; i < categories.length; i++) {
      final url =
          'https://us-central1-techspardha-87928.cloudfunctions.net/api/events/description?eventCategory=${categories[i]}';
      print(url);
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);
      final events = data['data']['events'];
      // debugPrint(events.toString());
      List<Event> eventList =
          events.map<Event>((json) => Event.fromJson(json)).toList();
      eventsMap[categories[i]] = new Map();

      eventList.forEach((element) {
        eventsMap[categories[i]]![element.eventName] = element;
      });
    }
  }
}
