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
    bool isflagship = (item.flagship.toString() == "true") ? true : false;
    return Container(
      child: Card(
          color: Colors.transparent,
          margin: const EdgeInsets.only(top: 10),
          borderOnForeground: true,
          elevation: 0,
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
              decoration: boxDecoration.copyWith(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  (isflagship)
                      ? Positioned(
                          child: Icon(
                            Icons.star,
                            color: white,
                          ),
                          top: 0.0,
                          right: 0.0,
                        )
                      : SizedBox(),
                  Row(
                    children: <Widget>[
                      Hero(
                          tag: item.eventName,
                          child: Container(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/images/techspardha.png',
                                    image: item.poster,
                                    fit: BoxFit.cover,
                                    imageCacheWidth: 1000,
                                    imageErrorBuilder: (context, error,
                                            stackTrace) =>
                                        Image.asset(
                                            'assets/images/techspardha.png'))),
                          )),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(item.eventName, style: h2s),
                              Text(
                                  item.description.length > 100
                                      ? item.description.substring(0, 100) +
                                          '...'
                                      : item.description,
                                  style: h6.copyWith(
                                      color: white.withOpacity(0.8))),
                              //  read more button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'Know more',
                                    style: h4.copyWith(
                                        color: const Color.fromARGB(255, 176, 175, 175).withOpacity(0.9),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: const Color.fromARGB(255, 171, 170, 170).withOpacity(0.9),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
