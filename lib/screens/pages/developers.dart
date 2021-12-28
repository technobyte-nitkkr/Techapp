import 'package:flutter/material.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/widgets/developer_card.dart';

class Developers extends StatelessWidget {
  Developers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: SafeArea(
        child: Scaffold(
          body: 
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: .85,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: <Widget>[
                DeveloperCard(
                  name: "Diet Recommendation",
                  imageSrc: "assets/icons/Hamburger.svg",
                  year: "4th",
                  link: "abcd",
                  press: () {},
                ),
              ],
            ),  
        ),
      ),
    );
  }
}
