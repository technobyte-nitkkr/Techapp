import 'package:flutter/material.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/widgets/developer_card.dart';

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
                        press: () {},
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
