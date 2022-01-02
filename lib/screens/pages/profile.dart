import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/widgets/sign_in_modal.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          getGradient(),
          Container(
              margin: EdgeInsets.all(50),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "User Profile Here",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SignInModalWidget(),
                              );
                            });
                      },
                      child: Text("Sign In Model check"))
                ],
              ))
        ],
      ),
    );
  }
}
