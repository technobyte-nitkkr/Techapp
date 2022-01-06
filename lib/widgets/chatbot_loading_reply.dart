import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatbotLoadingReply extends StatelessWidget {
  const ChatbotLoadingReply({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: new CircleAvatar(
            child: new Image.asset("assets/bot.png"),
            backgroundColor: Colors.transparent,
          ),
        ),
        Container(
          child: LoadingAnimationWidget.staggeredDotWave(
              color: Colors.white, size: 30),
        )
      ],
    );
  }
}
