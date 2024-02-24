// ignore: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';

class CustomPayloadDialog extends StatelessWidget {
  final Map<String, dynamic> payload;
  const CustomPayloadDialog({
    Key? key,
    required this.payload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final encodedPayload = json.decode(json.encode(payload))['payload'];

    // debugPrint(encodedPayload['text']);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(
              child: new Image.asset("assets/bot.png"),
              backgroundColor: Colors.transparent,
            ),
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: new Container(
                padding: const EdgeInsets.all(16.0),
                decoration: boxDecoration.copyWith(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (encodedPayload['text'] != null)
                      new Text(
                        encodedPayload['text'],
                        style: h2s,
                      ),
                    if (encodedPayload['route'] != null)
                      new ElevatedButton(
                        style: elevatedButtonStyle,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(encodedPayload['route']);
                        },
                        child: Text(
                          "Open",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
