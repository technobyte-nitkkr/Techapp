import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:techapp/models/categories.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/events_by_category.dart';

class SwiperCard extends StatelessWidget {
  final CategorySchema categoryName;
  final String fadeText;

  const SwiperCard(
      {Key? key, required this.categoryName, required this.fadeText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EventsByCategory(categoryName: categoryName)));
      },
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Stack(
                children: [
                  Card(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        gradient: null,
                        color: Colors.white.withOpacity(0.95),
                      ),
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                              height: min(
                                  MediaQuery.of(context).size.width * 0.32,
                                  400)),
                          AutoSizeText(
                            categoryName.categoryName
                                    .substring(0, 1)
                                    .toUpperCase() +
                                categoryName.categoryName.substring(1),
                            style: h1,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: <Widget>[
                              Text(
                                'Know more',
                                style: h4.copyWith(
                                    color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.left,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.05,
                    bottom: MediaQuery.of(context).size.width * 0.05,
                    child: Text(
                      fadeText,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: MediaQuery.of(context).size.width * 0.2,
                        color: black.withOpacity(0.3),
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Hero(
            tag: categoryName,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.125,
                right: MediaQuery.of(context).size.width * 0.125,
              ),

              // margin: EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(categoryName.imgUrl), fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
