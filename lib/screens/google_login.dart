import 'package:flutter/material.dart';
import 'package:techapp/screens/navigation.dart';
import 'package:techapp/services/firebase_services.dart';
import 'package:techapp/utils/colors.dart';

class GoogleLoginScreen extends StatefulWidget {
  const GoogleLoginScreen({Key? key}) : super(key: key);

  @override
  _GoogleLoginScreenState createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ElevatedButton(
            onPressed: () async {
              await FirebaseServices().signInWithGoogle();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Navigation()));
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return black;
              }
              return white;
            })),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/google.png",
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Google",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: black
                      ),
                  ),
                ],
              ),
            ),
          )],
        ),
      ),
    );
  }
}
