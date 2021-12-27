import 'package:techapp/models/EventByCategories.dart';
import 'package:techapp/models/Sponsor.dart';
import 'package:techapp/models/eventAll.dart';
import 'package:techapp/services/apiBaseHelper.dart';

// ignore: import_of_legacy_library_into_null_safe
import '../models/section.dart';

class FetchDataProvider {
  // data
  static Map<String, Map<String, Event>> eventsMap = new Map();
  static ApiBaseHelper _helper = ApiBaseHelper();
  static bool loading = false;
  static bool notification = false;
  static List<String> categories = [];
  static List<AllEvents> allEvents = [];
  static List<Sponsor> sponsors = [];
  static List<Event> myEvents = [];
  static List<Contacts> contacts = [];

  // functions

  // my events
  static loadMyevents(String? email) async {
    final data = await _helper.get('user/eventApp?email=$email');
    final events = data['data']['events'];
    final eventList =
        events.map<Event>((json) => Event.fromJson(json)).toList();
    myEvents = eventList;
  }

  // team altius
  static getContacts() async {
    final data = await _helper.get('contacts');
    var jsondata = data["data"]["contacts"];

    contacts =
        jsondata.map<Contacts>((json) => Contacts.fromJson(json)).toList();
  }

  // load sponsers
  static loadSponsor() async {
    final data = await _helper.get('foodsponsors');
    final sponsorsJSON =
        data['data']['foodSponsors'].cast<Map<String, dynamic>>();
    sponsors =
        sponsorsJSON.map<Sponsor>((json) => Sponsor.fromJson(json)).toList();
  }

  // load categories
  static Future<void> loadCategories() async {
    final data = await _helper.get('events/categories');
    final categoriesjson = data['data']['categories'];
    FetchDataProvider.categories =
        categoriesjson.map<String>((e) => e.toString()).toList();
  }

  // load events
  static Future<void> loadEvents() async {
    final data = await _helper.get('events');
    final events = data['data']['events'];
    FetchDataProvider.allEvents =
        events.map<AllEvents>((json) => AllEvents.fromJson(json)).toList();
  }

  // load events descripton an stroe to map
  static Future<void> loadEventDescription() async {
    for (int i = 0; i < FetchDataProvider.categories.length; i++) {
      final data = await _helper
          .get('events/description?eventCategory=${categories[i]}');
      final events = data['data']['events'];
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
