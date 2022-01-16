import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/widgets/sign_in_modal.dart';

class SmartButtonWidget extends StatefulWidget {
  final Event event;

  const SmartButtonWidget({Key? key, required this.event}) : super(key: key);
  @override
  _SmartButtonWidgetState createState() => _SmartButtonWidgetState();
}

class _SmartButtonWidgetState extends State<SmartButtonWidget> {
  final client = ApiClient.create();
  bool isLoading = false;
  bool isRegistered = false;
  final _user = FetchDataProvider.user;

  @override
  void initState() {
    for (int i = 0; i < FetchDataProvider.myEvents.length; i++) {
      if (FetchDataProvider.myEvents[i].eventName == widget.event.eventName) {
        isRegistered = true;
        break;
      }
    }
    super.initState();
  }

  void _registerEvent(
      String name, String category, BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      await client.addEvent(FetchDataProvider.jwt, {
        "eventName": name,
        "eventCategory": category,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Registered Successfully !!", textAlign: TextAlign.center),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              right: 20,
              left: 20)));
      var data = await client.getMyEvents(FetchDataProvider.jwt);
      data.getMyEvents();
      setState(() {
        isLoading = false;
        isRegistered = true;
      });
    } on DioError catch (e) {
      final errormessage = e.error.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errormessage, textAlign: TextAlign.center),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              right: 20,
              left: 20)));
      setState(() {
        isLoading = false;
      });
    }
  }

  void _unRegisterEvent(
      String name, String category, BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      await client.delEvent(FetchDataProvider.jwt, {
        "eventName": name,
        "eventCategory": category,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Unregistered Successfully !!", textAlign: TextAlign.center),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              right: 20,
              left: 20)));
      setState(() {
        isLoading = false;
        isRegistered = false;
      });
      await client.getMyEvents(FetchDataProvider.jwt);
    } on DioError catch (e) {
      final errormessage = e.error.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errormessage, textAlign: TextAlign.center),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              right: 20,
              left: 20)));

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("button build");
    return Container(
      height: 50,
      width: 250,
      child: ElevatedButton(
        style: !isRegistered
            ? ElevatedButton.styleFrom(
                primary: Colors.blueAccent[100],
                onPrimary: Colors.white,
                shadowColor: Colors.blue,
                elevation: 15,
                shape: (RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                )))
            : ElevatedButton.styleFrom(
                primary: Colors.redAccent[100],
                onPrimary: Colors.white,
                shadowColor: Colors.red,
                elevation: 15,
                shape: (RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ))),
        child: !isLoading
            ? Text(
                !isRegistered ? 'Register Now' : 'Unregister',
                style: h3.copyWith(color: white),
              )
            : LoadingAnimationWidget.threeRotatingDots(color: white, size: 30),
        onPressed: () async {
          if (DateTime.fromMicrosecondsSinceEpoch(widget.event.endTime * 1000,
                  isUtc: false)
              .isBefore(DateTime.now())) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Event has ended", textAlign: TextAlign.center),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 100,
                    right: 20,
                    left: 20)));
          } else if (!_user!.onBoard) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SignInModalWidget();
                });
          } else if (!isRegistered) {
            _registerEvent(
                widget.event.eventName, widget.event.eventCategory, context);
          } else {
            _unRegisterEvent(
                widget.event.eventName, widget.event.eventCategory, context);
          }
        },
      ),
    );
  }
}
