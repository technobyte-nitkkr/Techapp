// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dialogflow_flutter/message.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogCard extends StatelessWidget {
  DialogCard({required this.card});

  final CardDialogflow card;

  List<Widget> generateButton() {
    List<Widget> buttons = [];

    for (var i = 0; i < this.card.buttons.length; i++) {
      buttons.add(new SizedBox(
          child: new ElevatedButton(
              style: elevatedButtonStyle,
              onPressed: () async {
                debugPrint('dialog card');
                if (!await launch(this.card.buttons[i].postback)) {
                  debugPrint("Invalid link !!");
                }
              },
              child: AutoSizeText(
                this.card.buttons[i].text,
                maxLines: 1,
              ))));
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
                decoration: boxDecoration.copyWith(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                            new Text(this.card.title,
                                style: h3.copyWith(color: white)),
                          if (this.card.subtitle != null)
                            new Text(this.card.subtitle, style: h4s),
                        ],
                      ),
                    ),
                    if (this.card.buttons != null)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: this.card.buttons.length,
                        padding: EdgeInsets.all(20),
                        itemBuilder: (BuildContext ctx, int index) {
                          return this.generateButton()[index];
                        },
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 40,
                          maxCrossAxisExtent: 140,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
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
