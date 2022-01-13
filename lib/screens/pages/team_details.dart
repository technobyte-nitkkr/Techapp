// @dart=2.9
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/widgets/contactCard.dart';

class TeamDetail extends StatelessWidget {
  final contacts;
  TeamDetail({
    Key key,
    this.contacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          getGradient(),
          Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Text(
                contacts.section,
                style: Pagelabel,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Swiper(
                  itemCount: contacts.people.length,
                  itemHeight: MediaQuery.of(context).size.height * 0.6,
                  itemWidth: MediaQuery.of(context).size.width * 0.5,
                  layout: SwiperLayout.DEFAULT,
                  autoplay: true,
                  autoplayDelay: 2000,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        activeSize: 20,
                        space: 8,
                        color: Colors.grey,
                        activeColor: white),
                  ),
                  itemBuilder: (context, index) {
                    return ContactSwiperCard(
                      people: contacts.people[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
