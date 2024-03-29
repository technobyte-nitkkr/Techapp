import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:techapp/models/section.dart';
import 'package:techapp/screens/components/style.dart';

class ContactSwiperCard extends StatelessWidget {
  final People people;
  const ContactSwiperCard({
    Key? key,
    required this.people,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        decoration: boxDecoration,
        child: Column(
          children: <Widget>[
            Container(
              child: Image.network(
                people.imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 150,
                cacheWidth: 13000,
              ),
            ),
            AutoSizeText(
              people.name,
              style: h2s,
              maxLines: 1,
            ),
            Divider(
              thickness: 3,
            ),
            AutoSizeText(
              people.post,
              textAlign: TextAlign.center,
              style: h5.copyWith(color: white.withOpacity(0.8)),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
