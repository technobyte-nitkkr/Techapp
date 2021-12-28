// @dart=2.9
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/widgets/chat_body.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
  }

  List<Map<String, dynamic>> messages = [];

  void sendMessage(String text) async {
    if (text.isEmpty) return;
    setState(() {
      addMessage(
        Message(text: DialogText(text: [text])),
        true,
      );
    });

    // dialogFlowtter.projectId = "deimos-apps-0905";

    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: text)),
    );

    if (response.message == null) return;
    setState(() {
      addMessage(response.message);
    });
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }

  @override
  void dispose() {
    dialogFlowtter.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getGradient(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('ChatBot'),
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              Expanded(child: AppBody(messages: messages)),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _controller,
                         decoration: new InputDecoration(
                          hintText: "Ask your query",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.send),
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
