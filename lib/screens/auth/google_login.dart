import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
      backgroundColor: Color.fromARGB(255, 0, 25, 38),
      body: SplashAnimation(),
    );
  }
}

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({Key? key}) : super(key: key);

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/NewBg.png"))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
              ),
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "TECHSPARDHA",
                style: h1s.copyWith(
                  fontSize: 45,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'RubikWetPaint',
                  color: white,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: const Color.fromRGBO(59, 130, 246, 1),
                      offset: const Offset(-2, 0),
                    ),
                    Shadow(
                      blurRadius: 4.0,
                      color: const Color.fromRGBO(59, 130, 246, 1),
                      offset: const Offset(2, 0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Frontier Reimagined",
                style: h1s.copyWith(
                  fontSize: 24,
                  fontFamily: 'Satoshi',
                  shadows: [
                    Shadow(
                        blurRadius: 8,
                        color: Colors.black26,
                        offset: Offset(6, 6))
                  ],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 100,
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
                      Text(
                        "Login",
                        style: h2,
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
                color: Colors.black.withOpacity(0.7),
                child: Center(
                    child: SpinKitSpinningLines(
                  color: const Color.fromARGB(255, 48, 136, 208),
                  size: 130,
                  lineWidth: 4,
                )),
              )
            : Container(),
      ],
    );
  }
}
