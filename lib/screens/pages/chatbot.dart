import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/message.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/widgets/basicCard.dart';
import 'package:techapp/screens/widgets/carousel_select.dart';
import 'package:techapp/screens/widgets/chatbot_loading_reply.dart';
import 'package:techapp/screens/widgets/customPayloadDialog.dart';
import 'package:techapp/screens/widgets/dialog_card.dart';
import 'package:techapp/screens/widgets/quickReplies.dart';
import 'package:techapp/screens/widgets/simple_message.dart';

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
  bool isdisabled = false;

  Widget _buildTextComposer() {
    if (_textController.text.length == 0)
      setState(() {
        isdisabled = true;
      });

    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).colorScheme.background),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                onChanged: _handleChange,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  disabledColor: Colors.grey,
                  icon: new Icon(
                    Icons.send,
                    color: isdisabled ? Colors.grey : Colors.blue,
                  ),
                  onPressed: () => isdisabled
                      ? null
                      : _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  dynamic getWidgetMessage(message) {
    TypeMessage ms = TypeMessage(message);

    if (ms.type == "basicCard") {
      return BasicCardWidget(card: BasicCardDialogflow(message));
    }
    if (ms.type == "carouselSelect") {
      return CarouselSelectWidget(
          carouselSelect: CarouselSelect(message),
          clickItem: (info) {
            debugPrint(info); // Item Click print List Keys
          });
    }
    if (ms.type == "card") {
      return DialogCard(card: CardDialogflow(message));
    }
    if (message.containsKey("quickReplies")) {
      return "quickReplies";
    }

    // if (ms.type == "simpleResponses") {
    //   var response = new SimpleResponses(message).simpleResponses[0];
    //   if(response)
    //   return SimpleMessage(
    //       text: response.displayText ?? response.textToSpeech, type: false);
    // }

    if (message.containsKey("text")) {
      var text = message["text"]["text"][0];
      if (text.toString().trim().length > 0)
        return SimpleMessage(text: text ?? "invalid", type: false);

      return null;
    }
    if (message.containsKey("payload")) {
      return CustomPayloadDialog(payload: message as Map<String, dynamic>);
    }

    return null;
  }

  void response(query) async {
    setState(() {
      _messages.insert(0, ChatbotLoadingReply());
    });
    _textController.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/dialog_flow_auth.json").build();
    DialogFlow dialogflow = DialogFlow(authGoogle: authGoogle, language: "en");
    AIResponse response = await dialogflow.detectIntent(query);
    List<dynamic>? messages = response.getListMessage();

    // ignore: unnecessary_null_comparison
    if (messages != null && messages.length > 0) {
      int quickindex = -1;
      for (var i = 0; i < messages.length; i++) {
        setState(() {
          _messages.removeAt(0);
        });
        dynamic message = getWidgetMessage(messages[i]);
        if (message != null && message != "quickReplies") {
          setState(() {
            _messages.insert(0, message);
          });
        } else if (message == "quickReplies") {
          quickindex = i;
        }
        if (i < messages.length - 1) {
          setState(() {
            _messages.insert(0, ChatbotLoadingReply());
          });
        }

        await Future.delayed(Duration(seconds: 1));
      }
      if (quickindex != -1) {
        // debugPrint(quickindex);
        setState(() {
          _messages.insert(
              0, QuickReplyWidget(replies: QuickReplies(messages[quickindex])));
        });
      }
    }
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    SimpleMessage message = new SimpleMessage(
      text: text,
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    response(text);
  }

  @override
  void initState() {
    super.initState();
    response("hi");
  }

  @override
  Widget build(BuildContext context) {
    this.buildContext = context;
    return Stack(
      children: [
        getGradient(context),
        new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            title: new Text("TechBot"),
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

  void _handleChange(String value) {
    if (value.length > 0) {
      setState(() {
        isdisabled = false;
      });
    } else {
      setState(() {
        isdisabled = true;
      });
    }
  }
}
