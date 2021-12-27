import 'package:flutter/material.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/eventDetail.dart';
// ignore: import_of_legacy_library_into_null_safe

class ListItem extends StatelessWidget {
  final String eventName;
  final String eventCategory;

  const ListItem(
      {Key? key, required this.eventName, required this.eventCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = FetchDataProvider.eventsMap[eventCategory]![eventName]!;

    return Card(
        margin: const EdgeInsets.only(top: 10),
        elevation: 10,
        // card with event image and name
        child: GestureDetector(
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventDetailWidget(
                          eventCategory: item.eventCategory,
                          eventName: item.eventName,
                        )))
          },
          child: Container(
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
                            image: item.file,
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
        ));
  }
}
