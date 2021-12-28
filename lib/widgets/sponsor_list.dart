import 'package:flutter/material.dart';
import 'package:techapp/models/sponsor.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SponsorsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FetchDataProvider.sponsors.length == 0)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return GridView.count(
          crossAxisCount: 2,
          childAspectRatio: .85,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: FetchDataProvider.sponsors
              .map<Widget>((sponsor) => CardItem(item: sponsor))
              .toList());
  }
}

class CardItem extends StatelessWidget {
  final Sponsor item;

  const CardItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20.0),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: white,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () => launch('${item.link}'),
        child: Container(
          padding: const EdgeInsets.all(0.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.56,
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
                Expanded(
                  child: Text(
                    '${item.name}',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
