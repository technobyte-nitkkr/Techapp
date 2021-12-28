// ignore: import_of_legacy_library_into_null_safe
import 'package:dialogflow_flutter/message.dart';
import 'package:flutter/material.dart';

class DialogCard extends StatelessWidget {
  DialogCard({required this.card});

  final CardDialogflow card;

  List<Widget> generateButton() {
    List<Widget> buttons = [];

    for (var i = 0; i < this.card.buttons.length; i++) {
      buttons.add(new SizedBox(
          child: new ElevatedButton(
        onPressed: () {},
        child: Text(this.card.buttons[i].text),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (this.card.imageUri != null)
                      Image.network(this.card.imageUri),
                    new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          if (this.card.title != null)
                            new Text(
                              this.card.title,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          if (this.card.subtitle != null)
                            new Text(
                              this.card.subtitle,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                        ],
                      ),
                    ),
                    if (this.card.buttons != null)
                      new Container(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
