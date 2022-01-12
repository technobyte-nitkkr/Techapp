import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:techapp/models/notification_model.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/widgets/notification_item.dart';

class NotificationsWidget extends StatefulWidget {
  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  List<Noti> _notificatinons = [];
  LocalStorage _storage = new LocalStorage('techapp.json');
  final _trackingScrollController = TrackingScrollController();

  @override
  void initState() {
    loadNotificaitons();
    super.initState();
  }

  loadNotificaitons() async {
    await _storage.ready;
    var data = await _storage.getItem('notifications');
    if (data != null) {
      _notificatinons = data.map<Noti>((i) => Noti.fromJson(i)).toList();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(FetchDataProvider.user?.toJson().toString());
    return PageLayout(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Scrollbar(
                controller: _trackingScrollController,
                isAlwaysShown: true,
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
                      primary: glowColor.withOpacity(0.7),
                      shadowColor: glowColor,
                      elevation: 5,
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                  onPressed: () {
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
