import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';

class DeveloperCard extends StatelessWidget {
  final String imageSrc;
  final String name;
  final String year;
  final String link;

  final Function()? press;

  const DeveloperCard({
    Key? key,
    required this.imageSrc,
    required this.name,
    required this.year,
    required this.link,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 17,
            spreadRadius: -23,
            color: kShadowColor,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Spacer(),
                Image.network(
                  imageSrc,
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                Divider(),
                AutoSizeText(
                  name,
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                AutoSizeText(
                  year + ' Year',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
