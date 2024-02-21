import 'package:dialogflow_flutter/message.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

class BasicCardWidget extends StatelessWidget {
  BasicCardWidget({required this.card});

  final BasicCardDialogflow card;

  List<Widget> generateButton() {
    List<Widget> buttons = [];

    for (var i = 0; i < this.card.buttons!.length; i++) {
      buttons.add(new SizedBox(
          child: new ElevatedButton(
        style: elevatedButtonStyle,
        onPressed: () async {
          Logger().d(this.card.buttons![i]['title']);
          if (this.card.buttons![i]['title'] == 'Share') {
            Logger().d(this.card.buttons![i]['title']);
            final uri =
                Uri.parse(this.card.buttons![i]['openUriAction']['uri']);
            final response = await http.get(uri);
            Share.shareXFiles([
              XFile.fromData(
                response.bodyBytes,
                name: 'Flutter 3',
                mimeType: 'image/png',
              ),
            ],
                subject: 'Techspardha',
                text:
                    'Stay updated with TechSpardha! Download our app for more related content:\nhttps://bit.ly/techspardhaapp\n\nFor more details, visit our website: http://techspardha.in');

            return;
          } else if (!await launchUrlString(
              this.card.buttons![i]['openUriAction']['uri'])) {
            debugPrint("Invalid Link !!");
          }
        },
        child: Text(this.card.buttons![i]['title'] ?? 'click here'),
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
                decoration: boxDecoration.copyWith(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (this.card.image?.imageUri != null)
                      new Image.network(
                        this.card.image!.imageUri!,
                        cacheWidth: 10000,
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
                              this.card.title!,
                              style: h2s,
                            ),
                          if (this.card.subtitle != null)
                            new Text(
                              this.card.subtitle!,
                              style: h6.copyWith(
                                color: white,
                              ),
                            ),
                          if (this.card.formattedText != null)
                            new Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              child: new Text(
                                this.card.formattedText!,
                                style: h6.copyWith(
                                  color: white,
                                ),
                              ),
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
                    SizedBox(height: 10.0)
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
