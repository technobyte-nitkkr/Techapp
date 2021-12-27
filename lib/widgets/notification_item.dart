import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificatonItemWidget extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String description;
  final String? link;

  const NotificatonItemWidget(
      {Key? key,
      this.imageUrl,
      required this.title,
      required this.description,
      this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      // card with event image and name
      child: GestureDetector(
        onTap: () async => {
          if (link == null || !await launch('$link'))
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('No link available'),
                      content: Text('No link available for this event'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ))
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Container(
                    width: 100,
                    height: 100,
                    child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/technologo.png',
                        image: imageUrl ?? '',
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
                        title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        description.length > 100
                            ? description.substring(0, 100) + '...'
                            : description,
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
          ),
        ),
      ),
    );
  }
}
