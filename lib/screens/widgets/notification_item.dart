import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
      color: Colors.transparent,
      // card with event image and name
      child: GestureDetector(
        onTap: () async => {
          if (link == null || !await launchUrlString('$link'))
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
          decoration: boxDecoration.copyWith(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Container(
                    width: 100,
                    height: 100,
                    child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/techspardha.png',
                        image: imageUrl ?? '',
                        fit: BoxFit.cover,
                        imageCacheWidth: 1000,
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/images/techspardha.png'))),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: h2s,
                      ),
                      Text(
                        description.length > 100
                            ? description.substring(0, 100) + '...'
                            : description,
                        style: h6.copyWith(
                          color: white,
                        ),
                      ),
                      //  read more button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Know more',
                            style: h4.copyWith(color: white.withOpacity(0.7)),
                            textAlign: TextAlign.left,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 15,
                            color: white.withOpacity(0.7),
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
