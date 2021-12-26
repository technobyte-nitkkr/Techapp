import 'package:techapp/models/EventByCategories.dart';
import 'package:techapp/models/Sponsor.dart';
import 'package:techapp/models/eventAll.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchDataProvider {
  // event map first key refer for category and second key refer to event name
  static Map<String, Map<String, Event>> eventsMap = new Map();

  static bool loading = false;

  // list of all categories
  static List<String> categories = [];
  // list of all events
  static List<AllEvents> allEvents = [];

  // sponsers
  static List<Sponsor> sponsors = [];

  static List<Event> myEvents = [];

  static loadMyevents(String? email) async {
    final url =
        'https://us-central1-techspardha-87928.cloudfunctions.net/api/user/eventApp?email=$email';
    print(url);
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    final events = data['data']['events'];
    final eventList =
        events.map<Event>((json) => Event.fromJson(json)).toList();
    myEvents = eventList;
  }

  static loadSponsor() async {
    // await Future.delayed(Duration(seconds: 2));
    final url =
        'https://us-central1-techspardha-87928.cloudfunctions.net/api/foodsponsors';
    final response = await http.get(Uri.parse(url));
    print(url);
    // print(response.body);
    final data = json.decode(response.body);
    final sponsorsJSON =
        data['data']['foodSponsors'].cast<Map<String, dynamic>>();
    sponsors =
        sponsorsJSON.map<Sponsor>((json) => Sponsor.fromJson(json)).toList();
    // print(sponsorsJSON);

    // EventList.events =
    //     events.map<Event>((json) => Event.fromJson(json)).toList();
  }

  static Future<void> loadCategories() async {
    final url =
        'https://us-central1-techspardha-87928.cloudfunctions.net/api/events/categories';
    print(url);
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    final categoriesjson = data['data']['categories'];
    FetchDataProvider.categories =
        categoriesjson.map<String>((e) => e.toString()).toList();
    // print(categoriesjson);
  }

  static Future<void> loadEvents() async {
    final url =
        'https://us-central1-techspardha-87928.cloudfunctions.net/api/events';
    print(url);
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    final events = data['data']['events'];
    FetchDataProvider.allEvents =
        events.map<AllEvents>((json) => AllEvents.fromJson(json)).toList();
  }

  static Future<void> loadEventDescription() async {
    for (int i = 0; i < FetchDataProvider.categories.length; i++) {
      final url =
          'https://us-central1-techspardha-87928.cloudfunctions.net/api/events/description?eventCategory=${categories[i]}';
      print(url);
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);
      final events = data['data']['events'];
      // debugPrint(events.toString());
      List<Event> eventList =
          events.map<Event>((json) => Event.fromJson(json)).toList();
      FetchDataProvider.eventsMap[FetchDataProvider.categories[i]] = new Map();

      eventList.forEach((element) {
        FetchDataProvider.eventsMap[FetchDataProvider.categories[i]]![
            element.eventName] = element;
      });
    }
  }
}
