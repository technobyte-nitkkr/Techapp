// @dart=2.9
import 'package:bubble/bubble.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:flutter/material.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final messageInsert = TextEditingController();
  List<Map> messsages = [];
  void response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/techchatbot.json").build();
    DialogFlow dialogflow = DialogFlow(authGoogle: authGoogle, language: "en");
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    String _text = aiResponse.getMessage().toString();
    setState(() {
      messsages.insert(0, {"data": 0, "message": _text});
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: messsages.length,
                itemBuilder: (context, index) => chat(
                    messsages[index]["message"].toString(),
                    messsages[index]["data"]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Divider(
                    height: 8.0,
                    color: white,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            style: TextStyle(color: white),
                            controller: messageInsert,
                            decoration: InputDecoration.collapsed(
                              hintText: "Send your message",
                              hintStyle: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.send,
                              size: 30.0,
                              color: white,
                            ),
                            onPressed: () {
                              if (messageInsert.text.isEmpty) {
                                print("empty message");
                              } else {
                                setState(() {
                                  messsages.insert(0, {
                                    "data": 1,
                                    "message": messageInsert.text
                                  });
                                });
                                response(messageInsert.text);
                                messageInsert.clear();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget chat(String message, int data) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Bubble(
        radius: Radius.circular(10.0),
        color: data == 0 ? Colors.blueAccent[200] : Colors.deepPurple[200],
        elevation: 0.0,
        alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (data == 0)
                CircleAvatar(
                  backgroundImage: AssetImage("assets/bot.png"),
                ),
              SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
