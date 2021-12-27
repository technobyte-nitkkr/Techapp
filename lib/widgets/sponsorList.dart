import 'package:flutter/material.dart';
import 'package:techapp/models/Sponsor.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';

// ignore: must_be_immutable
class SponsorsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FetchDataProvider.sponsors.length == 0)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return ListView.builder(
          shrinkWrap: true,
          itemCount: FetchDataProvider.sponsors.length,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return ListItem(item: FetchDataProvider.sponsors[index]);
          });
  }
}

class ListItem extends StatelessWidget {
  final Sponsor item;

  const ListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      color: white,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.56,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(32),
                    topLeft: Radius.circular(32)),
                child: Image.network(
                  '${item.imageurl}',
                  height: 300,
                ),
              ),
              Divider(
                color: black,
                thickness: 5,
              ),
              Expanded(
                child: Text(
                  '${item.name}',
                  style: TextStyle(
                      fontFamily: 'Avenir',
                      color: const Color(0xff47455f),
                      fontWeight: FontWeight.w900,
                      fontSize: 26),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
