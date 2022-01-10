import 'dart:ui';

import 'package:flutter/material.dart';

const glowColor = Color(0xFF03bcf4);

const grey = Color(0xFF888888);
const black = Color(0xFF000000);
const white = Color(0xFFFFFFFF);
Color gradientStartColor = Color(0x00736AB7);
Color gradientEndColor = Color(0xFF9354B9);
Color gradientStartColor2 = Color(0xFF152233);
Color gradientEndColor2 = Color(0xFF710a5b);
Color technoBackColor = Color(0xFF143642);

const mainTitle = TextStyle(
  fontSize: 26.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontFamily: 'OpenSans SemiBold',
);

const Pagelabel = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w500,
  color: white,
  fontFamily: 'OpenSans SemiBold',
);

const h1 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w900,
  color: black,
  fontFamily: 'OpenSans Bold',
);
const h1s = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w900,
  color: white,
  fontFamily: 'OpenSans Bold',
);

const h2 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: black,
  fontFamily: 'OpenSans SemiBold',
);
const h2s = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: white,
  fontFamily: 'OpenSans SemiBold',
);

const h3 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: black,
  fontFamily: 'OpenSans SemiBold',
);

const h4 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: black,
  fontFamily: 'OpenSans SemiBold',
);
const h4s = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: white,
  fontFamily: 'OpenSans SemiBold',
);

const h5 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: black,
  fontFamily: 'OpenSans SemiBold',
);

const h6 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: black,
  fontFamily: 'OpenSans SemiBold',
);

const paraBlack = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: black,
  fontFamily: 'OpenSans SemiBold',
);

const parawhite = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: white,
  fontFamily: 'OpenSans SemiBold',
);

Container getGradient() {
  return new Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/back.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(
        decoration: BoxDecoration(
          color: black.withOpacity(0.1),
        ),
      ),
    ),
  );
}
