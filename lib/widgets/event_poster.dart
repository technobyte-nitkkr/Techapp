import 'package:flutter/material.dart';

class EventPosterWidget extends StatelessWidget {
  const EventPosterWidget({Key? key, required this.item}) : super(key: key);
  final item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Center(
            child: Hero(
                tag: item.eventName,
                child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/altius.png',
                    image: item.poster,
                    fit: BoxFit.contain,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset('assets/images/altius.png')))),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
