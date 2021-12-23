import 'package:flutter/material.dart';
import 'package:techapp/models/EventByCategories.dart';
import 'package:techapp/screens/components/style.dart';
// ignore: import_of_legacy_library_into_null_safe

class ListItem extends StatelessWidget {
  final Event item;

  const ListItem({Key? key, required this.item})
      : assert(item != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 10),
        elevation: 10,
        // card with event image and name
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                  width: 100,
                  height: 100,
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/technologo.png',
                      image: item.file,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset('assets/images/technologo.png'))),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
