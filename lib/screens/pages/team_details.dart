import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:techapp/models/developers.dart';
import 'package:techapp/models/section.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/team_altius.dart';
import 'package:techapp/screens/widgets/contactCard.dart';

class TeamDetail extends StatelessWidget {
  final contacts;
  TeamDetail({
    Key? key,
    this.contacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: white,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          getGradient(context),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Text(
                  contacts.section,
                  style: Pagelabel,
                  textAlign: TextAlign.center,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: contacts.people.length,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemBuilder: (BuildContext ctx, int index) {
                    return ContactSwiperCard(people: contacts.people[index]);
                  },
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 250,
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
