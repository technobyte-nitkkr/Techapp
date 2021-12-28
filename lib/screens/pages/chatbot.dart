// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/message.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/widgets/basicCard.dart';
import 'package:techapp/widgets/carousel_select.dart';
import 'package:techapp/widgets/simple_message.dart';

class ChatBotWidget extends StatefulWidget {
  ChatBotWidget({Key? key}) : super(key: key);

  final String title = "google assistant";

  @override
  _ChatBotWidget createState() => new _ChatBotWidget();
}

class _ChatBotWidget extends State<ChatBotWidget> {
  final List<dynamic> _messages = <dynamic>[];
  final TextEditingController _textController = new TextEditingController();
  late BuildContext buildContext;
  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).backgroundColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  dynamic getWidgetMessage(message) {
    TypeMessage ms = TypeMessage(message);
    if (ms.platform == "ACTIONS_ON_GOOGLE") {
      if (ms.type == "simpleResponses") {
        return SimpleMessage(
          text: message['simpleResponses']['simpleResponses'][0]
              ['textToSpeech'],
          name: "Bot",
          type: false,
        );
      }
      if (ms.type == "basicCard") {
        return BasicCardWidget(card: BasicCardDialogflow(message));
      }
      if (ms.type == "carouselSelect") {
        return CarouselSelectWidget(
            carouselSelect: CarouselSelect(message),
            clickItem: (info) {
              print(info); // Item Click print List Keys
            });
      }
    }
    return null;
  }

  void Response(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/dialog_flow_auth.json").build();
    DialogFlow dialogflow = DialogFlow(authGoogle: authGoogle, language: "en");

    AIResponse response = await dialogflow.detectIntent(query);

    List<dynamic> messages = response.getListMessage();
    if (messages != null) {
      for (var i = 0; i < messages.length; i++) {
        dynamic message = getWidgetMessage(messages[i]);
        if (message != null) {
          setState(() {
            _messages.insert(0, message);
          });
        }
        // }
      }
    }
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    SimpleMessage message = new SimpleMessage(
      text: text,
      name: "Rances",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    Response(text);
  }

  @override
  Widget build(BuildContext context) {
    this.buildContext = context;
    return Stack(
      children: [
        getGradient(),
        new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            title: new Text("TechnoBot"),
            backgroundColor: Colors.transparent,
          ),
          body: new Column(children: <Widget>[
            new Flexible(
                child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            )),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ]),
        ),
      ],
    );
  }
}
