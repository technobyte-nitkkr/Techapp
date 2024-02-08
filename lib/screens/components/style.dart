// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

// colors
const glowColor = Color(0xFF367CFF);
const grey = Color(0xFF888888);
const black = Color(0xFF000000);
const white = Color(0xFFFFFFFF);

// custom styles buton
final elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: glowColor.withOpacity(0.7),
    shadowColor: glowColor,
    elevation: 5,
    padding: EdgeInsets.symmetric(
      horizontal: 15.0,
      vertical: 10.0,
    ),
    shape: (RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    )));

// custom container decoration
final boxDecoration = BoxDecoration(
  color: Color.fromARGB(255, 64, 112, 102).withOpacity(0.3),
  boxShadow: [
    BoxShadow(
      color: glowColor.withOpacity(0.3),
      blurRadius: 1,
      offset: Offset(0, 2),
    ),
  ],
);

// custom text styles
final baseTextStyle = const TextStyle(fontFamily: 'segoe');

final mainTitle = baseTextStyle.copyWith(
  fontSize: 26.0,
  fontWeight: FontWeight.bold,
);

final Pagelabel = baseTextStyle.copyWith(
  fontSize: 35,
  fontWeight: FontWeight.w900,
  color: white,
);
final h1 = baseTextStyle.copyWith(
  fontSize: 28,
  fontWeight: FontWeight.w900,
  color: black,
);
final h1s = h1.copyWith(color: white);

final h2 = baseTextStyle.copyWith(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: black,
);
final h2s = h2.copyWith(color: white);

final h3 = baseTextStyle.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: black,
);
final h3s = h3.copyWith(color: white);

final h4 = baseTextStyle.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: black,
);
final h4s = h4.copyWith(color: white);

final h5 = baseTextStyle.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: black,
);
final h5s = h5.copyWith(color: white);

final h6 = baseTextStyle.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: black,
);
final h6s = h6.copyWith(color: white);

final parawhite = baseTextStyle.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: white,
);

final parablack = parawhite.copyWith(color: black);

// custom gradient
Container getGradient(context) {
  return new Container(
      child: Stack(
    children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 0, 0).withOpacity(.9),
          image: DecorationImage(
            //image: AssetImage("assets/images/back.png"),
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      // CircularParticle(
      //   key: UniqueKey(),

      //   awayRadius: 1000,
      //   numberOfParticles: 100,
      //   speedOfParticles: 1,
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   onTapAnimation: true,
      //   particleColor: grey.withOpacity(0.5),
      //   awayAnimationDuration: Duration(milliseconds: 500),
      //   awayAnimationCurve: Curves.linear,
      //   maxParticleSize: 0,
      //   isRandomColor: true,
      //   randColorList: [
      //     grey,
      //     Color.fromARGB(255, 8, 70, 121),
      //   ],
      //   enableHover: true,
      //   hoverColor: grey,
      //   hoverRadius: 100,
      //   connectDots: true,
      // ),
    ],
  ));
}


/*
Container getGradient(context) {
  return Container(
    child: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 28, 15, 32),
            image: DecorationImage(
            image: AssetImage("assets/images/back.png"),
            fit: BoxFit.cover,
          ),
          ),
        ),
        CircularParticle(
          key: UniqueKey(),
          awayRadius: 1000,
          numberOfParticles: 1000,
          speedOfParticles: 1,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          onTapAnimation: true,
          particleColor: grey.withOpacity(0.7),
          awayAnimationDuration: Duration(milliseconds: 500),
          awayAnimationCurve: Curves.decelerate,
          maxParticleSize: 1, // Adjust the size of the dots
          isRandomColor: true,
          randColorList: [
            grey,
          ],
          enableHover: true,
          hoverColor: grey,
          hoverRadius: 100,
          connectDots: false, // Set to false to use dot particles
        ),
      ],
    ),
  );
} 
*/