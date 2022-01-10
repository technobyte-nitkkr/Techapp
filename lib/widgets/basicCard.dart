// ignore: import_of_legacy_library_into_null_safe
import 'package:dialogflow_flutter/message.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:url_launcher/url_launcher.dart';

class BasicCardWidget extends StatelessWidget {
  BasicCardWidget({required this.card});

  final BasicCardDialogflow card;

  List<Widget> generateButton() {
    List<Widget> buttons = [];

    for (var i = 0; i < this.card.buttons.length; i++) {
      buttons.add(new SizedBox(
          child: new ElevatedButton(
        onPressed: () async {
          if (!await canLaunch(this.card.buttons[i]['openUriAction']['uri'])) {
            print("Invalid Link !!");
          } else {
            await launch(
                this.card.buttons[i]['openUriAction']['uri'].toString());
          }
        },
        child: Text(this.card.buttons[i]['title'] ?? 'click here'),
      )));
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(
              child: new Image.asset("assets/bot.png"),
              backgroundColor: Colors.transparent,
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: new Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (this.card.image?.imageUri != null)
                      new Image.network(
                        this.card.image.imageUri,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (this.card.title != null)
                            new Text(
                              this.card.title,
                              style: h2,
                            ),
                          if (this.card.subtitle != null)
                            new Text(
                              this.card.subtitle,
                              style: h6,
                            ),
                          if (this.card.formattedText != null)
                            new Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              child: new Text(this.card.formattedText),
                            ),
                        ],
                      ),
                    ),
                    if (this.card.buttons != null)
                      new Container(
                        child: new Column(
                          children: generateButton(),
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
