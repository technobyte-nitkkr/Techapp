import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:techapp/models/data.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/screens/pages/events_by_category.dart';

class Home extends StatelessWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        child: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 20.0, left: 20.0),
          child: Column(
            children: <Widget>[
              Text(
                'Event Categories',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 35,
                  color: black,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                // decoration: BoxDecoration(border: Border.all(color: grey)),
                child: Swiper(
                  itemCount: categories.length,
                  itemWidth: MediaQuery.of(context).size.width - 2 * 50,
                  layout: SwiperLayout.STACK,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        activeSize: 20,
                        space: 8,
                        color: Colors.grey,
                        activeColor: Colors.black),
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, a, b) => EventsByCategory(
                              eventCategory: categories[index],
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1),
                              Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2),
                                      Text(
                                        categories[index].name,
                                        style: TextStyle(
                                          fontFamily: 'Avenir',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                          color: const Color(0xff47455f),
                                          fontWeight: FontWeight.w900,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(height: 16),
                                      Row(
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
                          Hero(
                            tag: categories[index].categoryName,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,

                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.125,
                                right:
                                    MediaQuery.of(context).size.width * 0.125,
                              ),

                              // margin: EdgeInsets.only(left: 30),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage(categories[index].iconImage),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 20,
                            bottom: MediaQuery.of(context).size.height * 0.15,
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                fontSize: 150,
                                color: black.withOpacity(0.09),
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    )));
  }
}
