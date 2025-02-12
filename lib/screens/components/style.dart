// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

// colors
const glowColor = Color(0xFF367CFF);
const grey = Color(0xFF888888);
const black = Color(0xFF000000);
const white = Color(0xFFFFFFFF);

// custom styles buton
final elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: white,
    // shadowColor: glowColor,
    textStyle: TextStyle(color: black),
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
  color: white.withOpacity(0.1),
  boxShadow: [
    BoxShadow(
      color: glowColor.withOpacity(0.4),
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
  fontSize: 30,
  fontWeight: FontWeight.w900,
  fontFamily: 'Satoshi',
  color: white,
);
final h1 = baseTextStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w200,
    color: black,
    fontFamily: 'Satoshi');
final h1s = h1.copyWith(color: white);

final h2 = baseTextStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w100,
    color: black,
    fontFamily: 'Satoshi');
final h2s = h2.copyWith(color: white);

final h3 = baseTextStyle.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: black,
);
final h3s = h3.copyWith(color: white);

final h4 = baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w100,
    color: black,
    fontFamily: 'Satoshi');
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
  return Container(
    child: Stack(
      children: [
        // Background Image
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(.9),
            image: DecorationImage(
              image: AssetImage("assets/images/NewBg.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Centered Logo with Opacity
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (int i = 1; i <= 4; i++)
                Container(
                  width: 40*(i+1) + (i * 60), // Increase size for each ring
                  height: 40*(i+1) + (i * 60),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          const Color.fromARGB(255, 128, 93, 233).withOpacity(0.05), // White with opacity
                      width: 2, // Thin ring
                    ),
                  ),
                ),

              // Logo Image with Opacity
              Opacity(
                opacity: 0.2,
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
