import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:techapp/models/notification_model.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/screens/widgets/notification_item.dart';

void _askPermission(context) async {
  await Permission.notification.isDenied.then((value) {
    Logger().d("permission denied");
    Logger().d(value);
    if (value) {
      Permission.notification.request();
    }
    Permission.notification.isPermanentlyDenied.then((value) {
      Logger().d("permission permanently denied");
      Logger().d(value);
      if (value) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Permission Required"),
                content: Text(
                    "Please allow notification permission to get the latest updates"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      openAppSettings();
                    },
                    child: Text("Open Settings"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                ],
              );
            });
      }
    });
  });
}

class NotificationsWidget extends StatefulWidget {
  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  List<Noti> _notificatinons = [];

  final _trackingScrollController = TrackingScrollController();

  @override
  void initState() {
    loadNotificaitons();
    super.initState();
  }

  loadNotificaitons() async {
    LocalStorage _storage = new LocalStorage('techapp.json');
    await _storage.ready;
    var data = await _storage.getItem('notifications');
    if (data != null) {
      _notificatinons = data.map<Noti>((i) => Noti.fromJson(i)).toList();
    }

    FetchDataProvider.notification = _notificatinons.length;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(FetchDataProvider.user?.toJson().toString());
    _askPermission(context);
    return PageLayout(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Scrollbar(
                controller: _trackingScrollController,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _trackingScrollController,
                  dragStartBehavior: DragStartBehavior.start,
                  child: Text("Notifications", style: Pagelabel),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _notificatinons.length == 0
                  ? Container(
                      child: Text("No notifications", style: h2s),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NotificatonItemWidget(
                          title: _notificatinons[index].title,
                          description: _notificatinons[index].body,
                          imageUrl: _notificatinons[index].image,
                          link: _notificatinons[index].link,
                        );
                      },
                      itemCount: _notificatinons.length,
                    ),
              // NotificatonItemWidget(title: "hello", description: "hi"),
              if (_notificatinons.length != 0)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color
                    foregroundColor: Colors.black, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the border radius as needed
                    ),
                    // You can customize other style properties as needed
                  ),
                  onPressed: () {
                    LocalStorage _storage = new LocalStorage('techapp.json');
                    _notificatinons.clear();
                    _storage.setItem('notifications', []);
                    FetchDataProvider.notification = 0;
                    setState(() {});
                  },
                  child: Text("Clear"),
                ),
              if (_notificatinons.length == 0 &&
                  FetchDataProvider.user?.role != "user")
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseMessaging.instance
                            .subscribeToTopic('dev')
                            .then((value) {
                          debugPrint("subscribed");
                        });
                        //
                      },
                      child: Text("Subscribe Dev"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseMessaging.instance
                            .unsubscribeFromTopic('dev');
                      },
                      child: Text("Unsubscribe Dev"),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
