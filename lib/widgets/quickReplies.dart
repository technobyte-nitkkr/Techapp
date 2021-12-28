import 'package:dialogflow_flutter/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuickReplyWidget extends StatelessWidget {
  QuickReplies replies;
  final bool _type = false;
  QuickReplyWidget({
    Key? key,
    required this.replies,
  }) : super(key: key);

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(
          child: new Image.asset("assets/bot.png"),
          backgroundColor: Colors.transparent,
        ),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                child: Column(
                  children: [
                    new Text(
                      "Other Similar Comamnds",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      replies.quickReplies
                          .reduce((value, element) => value + "\n" + element),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: otherMessage(context),
      ),
    );
  }
}
