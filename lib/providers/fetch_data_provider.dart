import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:techapp/models/Speaker.dart';
import 'package:techapp/models/Sponsor.dart';
import 'package:techapp/models/categories.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/models/event_all.dart';
import 'package:techapp/models/user.dart';
import 'package:techapp/providers/local_storage_provider.dart';
import 'package:techapp/retrofit/api_client.dart';

class FetchDataProvider {
  static bool loading = false;
  static int notification = 0;
  static List<AllEvents> allEvents = [];
  static List<Event> myEvents = [];
  static List<CategorySchema> categories = [];
  // ignore: avoid_init_to_null
  static UserDetails? user = null;
  static String jwt = "";
  static List<Sponsor> sponsors = [];
  static List<Speaker> speakers = [];

  static loadProfileOnline() async {
    final client = ApiClient.create();
    // get the user from local storage
    final _user = await NotificationsProvider.getUser();
    var _token;
    if (_user != null) {
      user = UserDetails.fromJson(_user);
      jwt = await NotificationsProvider.getToken();
      debugPrint("got the user form local storage");
    } else {
      _token = await NotificationsProvider.getToken();

      if (_token != null) {
        // debugPrint(_token.substring(0, 1000));
        // debugPrint(_token.substring(1000));
        debugPrint("got token form local storage");
        try {
          final data = await client.login({"idToken": _token});
          // debugPrint(data.toJson());
          if (data.success) {
            // debugPrint(data);
            var token = data.data['token'];
            FetchDataProvider.jwt = token;
            await NotificationsProvider.saveToken(token);
            // set login time

            // got the profle form api
            debugPrint("got the profile form api");

            user = data.getProfile();
            await NotificationsProvider.saveUser(user!);
          }
        } catch (e) {
          // debugPrint((e as DioError).toString());
          debugPrint(e.toString());
          await NotificationsProvider.clearStorage();
          await FirebaseAuth.instance.signOut();
        }
      }
    }
  }
}
