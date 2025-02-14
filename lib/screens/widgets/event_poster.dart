import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';

class EventPosterWidget extends StatelessWidget {
  const EventPosterWidget({Key? key, required this.item}) : super(key: key);
  final item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Stack(children: [
          getGradient(context),
          Center(
              child: Hero(
                  tag: item.eventName,
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/techspardha.jpg',
                      image: item.poster,
                      imageCacheWidth: 10000,
                      fit: BoxFit.contain,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset('assets/images/techspardha.jpg'))))
        ]),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
