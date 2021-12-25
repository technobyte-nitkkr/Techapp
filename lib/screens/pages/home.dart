import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:techapp/providers/event_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/widgets/Swipercard.dart';

class Home extends StatelessWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = FetchDataProvider.categories;
    return PageLayout(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, right: 20.0, left: 20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Event Categories',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 30,
                      color: white,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
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
                            activeColor: white),
                      ),
                      itemBuilder: (context, index) {
                        return SwiperCard(
                          categoryName: categories[index],
                          fadeText: (index + 1).toString(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
