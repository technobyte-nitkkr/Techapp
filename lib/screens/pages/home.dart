// @dart=2.9
import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/widgets/swiper_card.dart';

class Home extends StatelessWidget {
  Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return PageLayout(
      child: FutureBuilder(
        future: client.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DataToLoad(
              categories: snapshot.data.getCategories(),
            );
          } else if (snapshot.hasError) {
            final errormessage =
                json.decode((snapshot.error as DioError).response.toString());

            return Center(
              child: Text(
                errormessage['message'] ?? "Error",
                style: TextStyle(color: white, fontSize: 20),
              ),
            );
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: LoadingAnimationWidget.staggeredDotWave(
                  color: white, size: 150),
            ),
          );
        },
      ),
    );
  }
}

class DataToLoad extends StatelessWidget {
  final List<String> categories;
  const DataToLoad({
    Key key,
    this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
