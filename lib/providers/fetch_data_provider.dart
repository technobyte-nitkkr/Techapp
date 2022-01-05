import 'package:firebase_auth/firebase_auth.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/models/event_all.dart';
import 'package:techapp/models/user.dart';
import 'package:techapp/providers/local_storage_provider.dart';
import 'package:techapp/services/apiBaseHelper.dart';

class FetchDataProvider {
  // data

  static ApiBaseHelper _helper = ApiBaseHelper();
  static bool loading = false;
  static int notification = 0;
  static List<String> categories = [];
  static List<AllEvents> allEvents = [];
  static List<Event> myEvents = [];
  // ignore: avoid_init_to_null
  static UserDetails? user = null;

  static Future<void> loadEvents() async {
    final data = await _helper.get('events');
    final events = data['data']['events'];
    FetchDataProvider.allEvents =
        events.map<AllEvents>((json) => AllEvents.fromJson(json)).toList();
  }

  // load categories
  static Future<void> loadCategories() async {
    final data = await _helper.get('events/categories');
    final categoriesjson = data['data']['categories'];
    FetchDataProvider.categories =
        categoriesjson.map<String>((e) => e.toString()).toList();
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
