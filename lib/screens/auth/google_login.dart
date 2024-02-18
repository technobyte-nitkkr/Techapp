import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_animation/galaxy_animation.dart';

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

class _SplashAnimationState extends State<SplashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _loading = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 5), // Adjust the duration as needed
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"),
              fit: BoxFit.cover,
            ),
          ),
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
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * pi,
                    child: Image.asset(
                      'assets/images/moon1.png',
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
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
}
