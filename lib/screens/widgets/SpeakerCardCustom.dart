import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:techapp/models/Speaker.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:url_launcher/url_launcher.dart';

class GuestCardCustom extends StatelessWidget {
  final Speaker speaker;
  const GuestCardCustom({
    Key? key,
    required this.speaker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(
        children: [
          Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(
              top: 75,
            ),
            elevation: 5,
            borderOnForeground: true,
            child: Container(
              decoration: boxDecoration.copyWith(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Text(speaker.name, style: h1s),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, color: white),
                          SizedBox(width: 8.0),
                          Text(speaker.date,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: white,
                                fontWeight: FontWeight.bold,
                                //color: Colors.white,
                              )),
                        ],
                      ),
                      Row(children: [
                        Icon(Icons.alarm_on, color: white),
                        SizedBox(width: 8.0),
                        Text(speaker.time,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: white,
                              fontWeight: FontWeight.bold,
                              //color: Colors.white,
                            )),
                      ])
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ExpansionTile(
                      collapsedTextColor: white,
                      backgroundColor: Colors.transparent,
                      controlAffinity: ListTileControlAffinity.platform,
                      collapsedIconColor: white,
                      iconColor: Colors.white,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.facebook,
                              color: white,
                            ),
                            onPressed: () async {
                              await launch(speaker.facebook);
                            },
                          ),
                          IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.linkedin,
                              color: white,
                            ),
                            onPressed: () async {
                              await launch(speaker.linkedin);
                            },
                          ),
                          IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.instagram,
                              color: white,
                            ),
                            onPressed: () async {
                              await launch(speaker.insta);
                            },
                          ),
                        ],
                      ),
                      children: [
                        Text(
                          speaker.desc,
                          style: h5.copyWith(color: white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            style: elevatedButtonStyle,
                            onPressed: () {
                              launch(speaker.link);
                            },
                            child: Text("Meet link")),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: boxDecoration.copyWith(
                border: Border.all(
                  color: white,
                  width: 3,
                ),
                color: Colors.white24,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(27),
                // child: Image.network(
                //   speaker.imageurl,
                //   width: 130,
                //   height: 130,
                //   fit: BoxFit.cover,
                //   cacheWidth: 1300,
                // ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/techspardha.png',
                  image: speaker.imageurl,
                  fit: BoxFit.cover,
                  width: 130,
                  height: 130,
                  imageCacheWidth: 1000,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/techspardha.png',
                          fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
