// @dart=2.9
import 'dart:math';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/models/categories.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/screens/widgets/swiper_card.dart';

class Home extends StatelessWidget {
  Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategorySchema> cate = FetchDataProvider.categories;
    return PageLayout(
      child: Column(
        children: [
          if (cate.length > 0)
            DataToLoad(
              categories: cate,
            ),
          if (cate.length == 0)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: white, size: 100),
              ),
            )
        ],
      ),
    );
  }
}

class DataToLoad extends StatelessWidget {
  final List<CategorySchema> categories;
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
                style: Pagelabel,
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Swiper(
                  itemCount: categories.length,
                  itemWidth:
                      min(MediaQuery.of(context).size.width - 2 * 50, 600),
                  layout: SwiperLayout.DEFAULT,
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
