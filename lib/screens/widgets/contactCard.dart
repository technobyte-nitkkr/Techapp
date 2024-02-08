import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:techapp/models/section.dart';
import 'package:techapp/screens/components/style.dart';
// ignore: import_of_legacy_library_into_null_safe

class ContactSwiperCard extends StatelessWidget {
  final People people;
  const ContactSwiperCard({
    Key? key,
    required this.people,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Card(
                color: Colors.transparent,
                child: Container(
                  decoration: boxDecoration.copyWith(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: min(
                              MediaQuery.of(context).size.width * 0.55, 400)),
                      AutoSizeText(
                        people.name,
                        style: h2s.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 30),
                        maxLines: 1,
                        minFontSize: 20,
                        textAlign: TextAlign.center,
                      ),
                      AutoSizeText(
                        people.post,
                        style: h3.copyWith(color: white.withOpacity(0.7)),
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        minFontSize: 20,
                      ),
                      //SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 105,
          left: MediaQuery.of(context).size.width * 0.2,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: FadeInImage.assetNetwork(
                  imageCacheWidth: 1000,
                  placeholder: 'assets/images/techspardha.png',
                  image: people.imageUrl,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/techspardha.png',
                          fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
