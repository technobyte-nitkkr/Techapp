import 'package:flutter/material.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/widgets/developer_card.dart';
import 'package:url_launcher/url_launcher.dart';

class Developers extends StatelessWidget {
  Developers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: Column(
        children: [
          Text(
            "Developers",
            style: TextStyle(
              color: white,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: .85,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: FetchDataProvider.developers
                  .map<Widget>((developer) => DeveloperCard(
                      name: developer.name,
                      imageSrc: developer.imageurl,
                      year: developer.year,
                      link: developer.link,
                      press: () async {
                        if (!await canLaunch(developer.link)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Link Invalid !!",
                                  textAlign: TextAlign.center),
                              backgroundColor: Colors.orange,
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 3),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height - 100,
                                  right: 20,
                                  left: 20)));
                        } else {
                          await launch(developer.link);
                        }
                      }))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
