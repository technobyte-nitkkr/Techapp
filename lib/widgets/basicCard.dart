// ignore: import_of_legacy_library_into_null_safe
import 'package:dialogflow_flutter/message.dart';
import 'package:flutter/material.dart';

class BasicCardWidget extends StatelessWidget {
  BasicCardWidget({required this.card});

  final BasicCardDialogflow card;

  List<Widget> generateButton() {
    List<Widget> buttons = [];

    for (var i = 0; i < this.card.buttons.length; i++) {
      buttons.add(new SizedBox(
          child: new ElevatedButton(
        onPressed: () {},
        child: Text(this.card.buttons[i]['title']),
      )));
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: new Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: Image.network(this.card.image.imageUri),
            ),
            new Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    this.card.title,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  new Text(
                    this.card.subtitle,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
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
    );
  }
}
