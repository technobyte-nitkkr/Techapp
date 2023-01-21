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
                      width: MediaQuery.of(context).size.width * 0.9,

                      // padding: const EdgeInsets.all(32.0),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                                bottomLeft: Radius.circular(11),
                                bottomRight: Radius.circular(11),
                              ),
                              gradient: null,
                              color: Colors.white.withOpacity(1),
                            ),
                            child: Hero(
                              tag: categoryName,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.width * 0.5,
                                margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.075,
                                  right:
                                      MediaQuery.of(context).size.width * 0.075,
                                  top:
                                      MediaQuery.of(context).size.width * 0.075,
                                  bottom:
                                      MediaQuery.of(context).size.width * 0.075,
                                ),

                                // margin: EdgeInsets.only(left: 30),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(categoryName.imgUrl),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              // bottom: -MediaQuery.of(context).size.width * 0.1,
                              // margin: EdgeInsets.all(1),
                              // padding: EdgeInsets.all(2),
                              child: Container(
                            padding:
                                EdgeInsets.only(left: 20, right: 30, top: 1),
                            width: MediaQuery.of(context).size.width * 0.68,
                            height: MediaQuery.of(context).size.width * 0.12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(11),
                                bottomRight: Radius.circular(11),
                              ),
                              gradient: null,
                              color: Colors.white.withOpacity(1),
                            ),
                            child: Column(children: [
                              // SizedBox(height: 10),

                              AutoSizeText(
                                categoryName.categoryName
                                        .substring(0, 1)
                                        .toUpperCase() +
                                    categoryName.categoryName.substring(1),
                                style: h1.copyWith(fontFamily: 'sportsBall'),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                            ]),
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
