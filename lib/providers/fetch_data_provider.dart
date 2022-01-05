import 'package:firebase_auth/firebase_auth.dart';
import 'package:techapp/models/developers.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/models/sponsor.dart';
import 'package:techapp/models/event_all.dart';
import 'package:techapp/models/user.dart';
import 'package:techapp/models/Speaker.dart';
import 'package:techapp/providers/local_storage_provider.dart';
import 'package:techapp/services/apiBaseHelper.dart';
import '../models/section.dart';

class FetchDataProvider {
  // data
  static Map<String, Map<String, Event>> eventsMap = new Map();
  static ApiBaseHelper _helper = ApiBaseHelper();
  static bool loading = false;
  static int notification = 0;
  static List<String> categories = [];
  static List<AllEvents> allEvents = [];
  static List<Sponsor> sponsors = [];
  static List<Event> myEvents = [];
  static List<Contacts> contacts = [];
  static List<Developers> developers = [];
  static List<Speaker> speakers=[];
  // ignore: avoid_init_to_null
  static UserDetails? user = null;

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
  //load speakers
  static loadSpeaker() async {
    final data = await _helper.get('lectures');
    final speakersJSON = data['data']['lectures'].cast<Map<String, dynamic>>();
    print('hello');
    speakers = speakersJSON.map<Speaker>((json) => Speaker.fromJson(json)).toList();
    print(speakers.length);
  }


  // load categories
  static Future<void> loadCategories() async {
    final data = await _helper.get('events/categories');
    final categoriesjson = data['data']['categories'];
    FetchDataProvider.categories =
        categoriesjson.map<String>((e) => e.toString()).toList();
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
        allEvents.add(AllEvents(
            eventName: element.eventName,
            eventCategory: element.eventCategory));
      });
    }
  }

  static loadDevelopers() async {
    final data = await _helper.get('aboutAppDevs');
    final developersJSON =
        data['data']['information'].cast<Map<String, dynamic>>();
    developers = developersJSON
        .map<Developers>((json) => Developers.fromJson(json))
        .toList();
  }

  static loadProfileOnline() async {
    // get the user from local storage
    final _user = await NotificationsProvider.getUser();
    var _token;
    if (_user != null) {
      user = UserDetails.fromJson(_user);
      print("got the user form local storage");
    } else {
      _token = await NotificationsProvider.getToken();

      if (_token != null) {
        print(_token.substring(0, 1000));
        print(_token.substring(1000));
        print("got token form local storage");
        try {
          final data = await _helper.post('loginApp', {'idToken': _token});
          print(data);
          final isOnboard = data['onBoard'] ?? null;
          if (isOnboard == null || isOnboard == false) {
            user = null;
            // throw Exception("not onboard");
          }
          // got the profle form api
          print("got the profile form api");

          final profile = data['information'] as Map<String, dynamic>;
          user = UserDetails.fromJson(profile);
          await NotificationsProvider.saveUser(user!);
        } catch (e) {
          // signout the user
          print(e);
          await FirebaseAuth.instance.signOut();
        }
      }
    }
  }
}
