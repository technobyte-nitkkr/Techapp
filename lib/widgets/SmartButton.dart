import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/services/apiBaseHelper.dart';
import 'package:techapp/widgets/sign_in_modal.dart';

class SmartButtonWidget extends StatefulWidget {
  const SmartButtonWidget(
      {Key? key, required this.eventName, required this.eventCategory})
      : super(key: key);

  final eventName, eventCategory;
  @override
  _SmartButtonWidgetState createState() => _SmartButtonWidgetState();
}

class _SmartButtonWidgetState extends State<SmartButtonWidget> {
  bool isLoading = false;
  bool isRegistered = false;
  final _user = FetchDataProvider.user;

  @override
  void initState() {
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
    setState(() {
      isLoading = false;
      isRegistered = true;
    });
  }

  void _unRegisterEvent(
      String? email, String name, String category, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text("Backend Api not available !!", textAlign: TextAlign.center),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20)));
  }

  @override
  Widget build(BuildContext context) {
    print("button build");
    return Container(
      height: 50,
      width: 250,
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
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
                style: TextStyle(fontSize: 25, color: Colors.white),
              )
            : LoadingAnimationWidget.threeHorizontalDots(
                color: white, size: 30),
        onPressed: () {
          if (!_user!.onBoard) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: SignInModalWidget(),
                  );
                });
          } else if (!isRegistered) {
            _registerEvent(
                _user!.email, widget.eventName, widget.eventCategory, context);
          } else {
            _unRegisterEvent(
                _user!.email, widget.eventName, widget.eventCategory, context);
          }
        },
      ),
    );
  }
}
