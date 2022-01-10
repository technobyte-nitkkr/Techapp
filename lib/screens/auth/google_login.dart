import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/screens/auth/firebase_services.dart';
import 'package:techapp/screens/components/style.dart';

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
      body: SplashAnimation(),
    );
  }
}

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getGradientLock(),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  AutoSizeText(
                    'Made with  ',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: white, fontSize: 22),
                  ),
                  FaIcon(
                    FontAwesomeIcons.solidHeart,
                    size: 22,
                    color: white,
                  ),
                  AutoSizeText(
                    ' by Technobyte ',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: white, fontSize: 22),
                  )
                ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });
                  await FirebaseServices().signInWithGoogle();

                  Navigator.popUntil(context, (route) => false);
                  setState(() {
                    _loading = false;
                  });

                  Navigator.pushNamed(context, '/splash');
                },
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return black;
                  }
                  return white;
                })),
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/google.png",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Login",
                        style: mainTitle,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        _loading
            ? Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                    child: LoadingAnimationWidget.staggeredDotWave(
                        color: white, size: 100)),
              )
            : Container(),
      ],
    );
  }
}
