import 'package:flutter/material.dart';
import 'package:flutter_earth_globe/sphere_style.dart';
import 'package:galaxy_animation/galaxy_animation.dart';
import 'package:flutter_earth_globe/flutter_earth_globe.dart';
import 'package:flutter_earth_globe/flutter_earth_globe_controller.dart';

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
  final FlutterEarthGlobeController _controller = FlutterEarthGlobeController(
      rotationSpeed: 0.1,
      // isRotating: true,
      sphereStyle: (SphereStyle(
          shadowColor: Colors.orange.withOpacity(0.8), shadowBlurSigma: 20)),
      isBackgroundFollowingSphereRotation: true,
      background: Image.asset('assets/images/background.jpg').image,
      surface: Image.asset('assets/images/Planet_2.png').image);
  bool _loading = false;
  @override
  void initState() {
    _controller.onLoaded = () {
      _controller.startRotation();
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
            child: FlutterEarthGlobe(
          controller: _controller,
          // alignment: Alignment.bottomCenter,
          radius: 80,
        )),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // decoration: BoxDecoration(
          //   color: Colors.black,
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/back.jpg"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
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
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Starlord',
                  color: white,
                  shadows: [
                    Shadow(
                      blurRadius: 1.0,
                      color: Color(0xFF367cff),
                      offset: Offset(2, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Infinite Imagination",
                style: h1s.copyWith(
                  fontSize: 24,
                  fontFamily: 'Orbitron',
                  // add shadows

                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // FlutterEarthGlobe(
              //   controller: _controller,
              //   radius: 1,
              // ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });
                  _controller.startRotation();
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
                color: Colors.black.withOpacity(0.5),
                child: Center(
                    child: GalaxyAnimation(
                  lineColor: white,
                  planetColor: glowColor,
                )),
              )
            : Container(),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
