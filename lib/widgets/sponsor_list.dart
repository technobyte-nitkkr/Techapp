// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:techapp/models/Sponsor.dart';

import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SponsorsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));

    return FutureBuilder(
      future: client.getSponsors(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.data.success) {
            return Center(
              child: Text("Error"),
            );
          } else {
            return GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: .85,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: snapshot.data
                    .getFoodSponsors()
                    .map<Widget>((sponsor) => CardItem(item: sponsor))
                    .toList());
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class CardItem extends StatelessWidget {
  final Sponsor item;

  const CardItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: white,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () => launch('${item.link}'),
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Divider(
                color: grey,
                thickness: 2,
              ),
              ClipRRect(
                child: Image.network(
                  '${item.imageurl}',
                  height: 100,
                ),
              ),
              Divider(
                color: grey,
                thickness: 2,
              ),
              AutoSizeText(
                '${item.name}',
                style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 18),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
