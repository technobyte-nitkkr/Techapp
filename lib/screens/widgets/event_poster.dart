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
          getGradient(),
          Center(
              child: Hero(
                  tag: item.eventName,
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/techspardha.png',
                      image: item.poster,
                      fit: BoxFit.contain,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset('assets/images/techspardha.png'))))
        ]),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
