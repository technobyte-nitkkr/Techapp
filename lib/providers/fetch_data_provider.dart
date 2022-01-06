import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  // ignore: avoid_init_to_null
  static UserDetails? user = null;
  static String jwt = "";

  static loadProfileOnline() async {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    // get the user from local storage
    final _user = await NotificationsProvider.getUser();
    var _token;
    if (_user != null) {
      if (await NotificationsProvider.checkLoginTime()) {
        print("login expired");
        await FirebaseAuth.instance.signOut();
      }

      user = UserDetails.fromJson(_user);
      jwt = await NotificationsProvider.getToken();
      print("got the user form local storage");
    } else {
      _token = await NotificationsProvider.getToken();

      if (_token != null) {
        // print(_token.substring(0, 1000));
        // print(_token.substring(1000));
        print("got token form local storage");
        try {
          final data = await client.login({"idToken": _token});
          print(data.toJson());
          if (data.success) {
            print(data);
            var token = data.data['token'];
            FetchDataProvider.jwt = token;
            await NotificationsProvider.saveToken(token);
            // set login time
            await NotificationsProvider.saveLoginTime();
            // got the profle form api
            print("got the profile form api");

            user = data.getProfile();
            await NotificationsProvider.saveUser(user!);
          }
        } catch (e) {
          // print((e as DioError).toString());
          print(e);
          await NotificationsProvider.clearStorage();
          await FirebaseAuth.instance.signOut();
        }
      }
    }
  }
}
