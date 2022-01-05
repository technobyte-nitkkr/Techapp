import 'dart:ui';

import 'package:flutter/material.dart';

const primaryColor = Color(0xFFec1b34);
const secondaryColor = Color(0xFFffb500);
const bgColor = Color(0xFFecf0f5);
const grey = Color(0xFF888888);
const black = Color(0xFF000000);
const white = Color(0xFFFFFFFF);
Color gradientStartColor = Color(0x00736AB7);
Color gradientEndColor = Color(0xFF9354B9);
Color navigationColor = Color(0xFF6751B5);
Color gradientStartColor2 = Color(0xFF152233);
Color gradientEndColor2 = Color(0xFF710a5b);
Color technoBackColor = Color(0xFF143642);
const kBackgroundColor = Color(0xFFF8F8F8);
const kActiveIconColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kBlueLightColor = Color(0xFFC7B8F5);
const kBlueColor = Color(0xFF817DC0);
const kShadowColor = Color(0xFFE6E6E6);

const defaultPadding = 20.0;

// ignore: prefer_const_constructors
final TextStyle mainTitle = TextStyle(
  fontSize: 26.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontFamily: 'OpenSans SemiBold',
);

Container getGradient() {
  return new Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0, 1],
        colors: [gradientStartColor2, gradientEndColor2],
      ),
    ),
    child: BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        decoration: BoxDecoration(
          color: gradientStartColor2.withOpacity(0.4),
        ),
      ),
    ),
  );
}
