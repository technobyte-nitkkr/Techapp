import 'package:flutter/material.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/event_detail.dart';
// ignore: import_of_legacy_library_into_null_safe

class ListItem extends StatelessWidget {
  final Event item;

  const ListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isflagship = (item.flagship.toString() == 'true') ? true : false;
    Color eventcolor = isflagship ? Colors.amber : Colors.white;

    return Container(
      child: Card(
          color: Colors.transparent,
          margin: const EdgeInsets.only(top: 10),
          borderOnForeground: true,
          elevation: 5,
          shadowColor: Colors.grey,
          child: GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailWidget(
                    item: item,
                  ),
                ),
              )
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: eventcolor, width: 3)),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Hero(
                      tag: item.eventName,
                      child: Container(
                          width: 100,
                          height: 100,
                          child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/technologo.png',
                              image: item.poster,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset('assets/images/technologo.png'))),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.eventName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item.description.length > 100
                                  ? item.description.substring(0, 100) + '...'
                                  : item.description,
                              style: TextStyle(fontSize: 15),
                            ),
                            //  read more button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Know more',
                                  style: TextStyle(
                                    fontFamily: 'Avenir',
                                    fontSize: 18,
                                    color: grey,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                  ],
                )),
          )),
    );
  }
}
