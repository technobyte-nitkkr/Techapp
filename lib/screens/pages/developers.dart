// @dart=2.9
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:techapp/models/developers.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/widgets/developer_card.dart';

class Developers extends StatelessWidget {
  Developers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = ApiClient.create();
    return PageLayout(
      child: Column(
        children: [
          Text(
            "Developers",
            style: TextStyle(
              color: white,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: FutureBuilder(
                future: client.getAboutDev(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    final errormessage =
                        (snapshot.error as DioError).error.toString();
                    print(errormessage);
                    return Center(
                      child: Text(
                        errormessage ?? "Error",
                        style: TextStyle(color: white, fontSize: 20),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    List<Developer> developers = snapshot.data.getDevelopers();
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: developers.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return DeveloperWidget(developer: developers[index]);
                      },
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                            color: white, size: 200),
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class DeveloperWidget extends StatelessWidget {
  final Developer developer;
  const DeveloperWidget({
    Key key,
    this.developer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeveloperCard(
        name: developer.name,
        imageSrc: developer.imageurl,
        year: developer.year,
        link: developer.link,
        press: () async {
          if (!await canLaunch(developer.link)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Link Invalid !!", textAlign: TextAlign.center),
                backgroundColor: Colors.orange,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 100,
                    right: 20,
                    left: 20)));
          } else {
            await launch(developer.link);
          }
        });
  }
}
