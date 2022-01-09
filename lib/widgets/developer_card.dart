import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeveloperCard extends StatelessWidget {
  final String imageSrc;
  final String name;
  final String year;
  final String github;
  final String linkedin;
  final String insta;

  const DeveloperCard({
    Key? key,
    required this.imageSrc,
    required this.name,
    required this.year,
    required this.github,
    required this.linkedin,
    required this.insta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
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
              fontSize: 20,
            ),
            maxLines: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 2,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: FaIcon(FontAwesomeIcons.github),
                onPressed: () async {
                  if (!await launch(linkedin)) {
                    // show snackbar cannot show link
                    ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                        text: "couldnot process request", context: context));
                  }
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.linkedin),
                onPressed: () async {
                  if (!await launch(linkedin)) {
                    // show snackbar cannot show link
                    ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                        text: "couldnot process request", context: context));
                  }
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.instagram),
                onPressed: () async {
                  if (!await launch(insta)) {
                    // show snackbar cannot show link
                    ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                        text: "couldnot process request", context: context));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
SnackBar CustomSnackbar({required String text, required BuildContext context}) {
  return SnackBar(
    content: Text(text, textAlign: TextAlign.center),
    backgroundColor: Colors.yellow,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100, right: 20, left: 20),
  );
}
