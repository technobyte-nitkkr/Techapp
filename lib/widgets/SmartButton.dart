import 'package:flutter/material.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/services/apiBaseHelper.dart';

class SmartButtonWidget extends StatefulWidget {
  const SmartButtonWidget(
      {Key? key,
      required this.email,
      required this.eventName,
      required this.eventCategory})
      : super(key: key);

  final email, eventName, eventCategory;
  @override
  _SmartButtonWidgetState createState() => _SmartButtonWidgetState();
}

class _SmartButtonWidgetState extends State<SmartButtonWidget> {
  bool isLoading = false;
  bool isRegistered = false;

  @override
  void initState() {
    //bool result = FetchDataProvider.myEvents.contains(element)
    for (int i = 0; i < FetchDataProvider.myEvents.length; i++) {
      if (FetchDataProvider.myEvents[i].eventName == widget.eventName) {
        isRegistered = true;
        break;
      }
    }
    super.initState();
  }

  void _registerEvent(
      String? email, String name, String category, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final ApiBaseHelper _helper = ApiBaseHelper();
    await _helper.put('user/eventApp',
        {'email': email, 'eventName': name, 'eventCategory': category});
    await FetchDataProvider.loadMyevents;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text("Registered Successfully !!", textAlign: TextAlign.center),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20)));
    setState(() {
      isLoading = false;
      isRegistered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("button build");
    return Container(
      child: ElevatedButton(
        style: !isRegistered
            ? ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue))
            : ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
        child: !isLoading
            ? Text(
                !isRegistered ? 'Register Now' : 'Unregister',
              )
            : CircularProgressIndicator(
                color: Colors.white,
              ),
        onPressed: () {
          if (!isRegistered) {
//call register api
            _registerEvent(
                widget.email, widget.eventName, widget.eventCategory, context);
          } else {
// call un-register api
          }
        },
      ),
    );
  }
}
