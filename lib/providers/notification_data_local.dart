import 'package:localstorage/localstorage.dart';
import 'package:techapp/models/notificationModel.dart';

class NotificationsProvider {
  //
  static List<Noti> list = [];
  static LocalStorage storage = new LocalStorage('techapp.json');

  // function to save to storage
  static _saveToStorage() async {
    await storage.ready;
    await storage.setItem(
        'notifications', list.map((i) => i.toJson()).toList());
  }

  // check the notification list if present
  static Future<bool> checkNoti() async {
    await storage.ready;
    var notiList = await storage.getItem('notifications');
    if (notiList != null && notiList.length > 0) {
      return true;
    }
    return false;
  }

  // add notification to list
  static addItem(String title, String body,
      {String? link, String? image}) async {
    // load previous data
    await storage.ready;
    var items = await storage.getItem('notifications');

    if (items != null) {
      list = items.map<Noti>((i) => Noti.fromJson(i)).toList();
    }
    final item = new Noti(body: body, title: title, link: link, image: image);
    list.add(item);
    await _saveToStorage();
  }

  // clear storage;
  static clearStorage() async {
    await storage.ready;
    await storage.clear();
  }
}
