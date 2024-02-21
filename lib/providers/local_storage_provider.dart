import 'package:localstorage/localstorage.dart';
import 'package:techapp/models/notification_model.dart';
import 'package:techapp/models/user.dart';
import 'package:techapp/providers/fetch_data_provider.dart';

class NotificationsProvider {
  // data
  static List<Noti> list = [];

  // function to save to storage
  static _saveToStorage() async {
    LocalStorage storage = new LocalStorage('techapp.json');
    await storage.ready;
    await storage.setItem(
        'notifications', list.map((i) => i.toJson()).toList());
  }

  // check the notification list if present
  static Future<int> checkNoti() async {
    LocalStorage storage = new LocalStorage('techapp.json');
    await storage.ready;
    var notiList = await storage.getItem('notifications');
    if (notiList != null && notiList.length > 0) {
      FetchDataProvider.notification = notiList.length;
      return notiList.length;
    }
    return 0;
  }

  // add notification to list
  static addItem(String title, String body,
      {String? link, String? image}) async {
    // load previous data
    LocalStorage storage = new LocalStorage('techapp.json');
    await storage.ready;
    var items = await storage.getItem('notifications');
    if (items != null) {
      list = items.map<Noti>((i) => Noti.fromJson(i)).toList();
    }
    final item = new Noti(body: body, title: title, link: link, image: image);
    list.add(item);
    FetchDataProvider.notification++;
    await _saveToStorage();
  }

  // clear storage;
  static clearStorage() async {
    LocalStorage storage = new LocalStorage('techapp.json');
    await storage.ready;
    await storage.clear();
  }

  // save the jwt token in the storage
  static saveToken(String token) async {
    LocalStorage storage = new LocalStorage('techapp.json');
    await storage.ready;
    await storage.setItem('token', token);
  }

  // get the jwt token from the storage
  static Future<String?> getToken() async {
    LocalStorage storage = new LocalStorage('techapp.json');
    await storage.ready;
    return await storage.getItem('token');
  }

  // save the user to local storage
  static saveUser(UserDetails user) async {
    LocalStorage storage = new LocalStorage('techapp.json');
    await storage.ready;
    await storage.setItem('user', user.toJson());
  }

  // get the user from the storage
  static Future<dynamic> getUser() async {
    LocalStorage storage = new LocalStorage('techapp.json');
    await storage.ready;
    return await storage.getItem('user');
  }
}
