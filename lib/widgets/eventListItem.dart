import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techapp/models/EventByCategories.dart';
import 'package:techapp/providers/event_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/widgets/eventDetail.dart';
// ignore: import_of_legacy_library_into_null_safe

class ListItem extends StatelessWidget {
  final String eventName;
  final String eventCategory;
  final String categoryImage;

  const ListItem(
      {Key? key,
      required this.eventName,
      required this.eventCategory,
      required this.categoryImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<FetchDataProvider>(context);
    final item = data.eventsMap[eventCategory]![eventName]!;
    return Card(
        margin: const EdgeInsets.only(top: 10),
        elevation: 10,
        // card with event image and name
        child: GestureDetector(
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EventDetailWidget(item: item, cimage: categoryImage)))
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
