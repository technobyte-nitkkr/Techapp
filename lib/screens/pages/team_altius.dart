// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:techapp/models/section.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/screens/pages/team_details.dart';

class TeamAltius extends StatefulWidget {
  TeamAltius({
    Key key,
  }) : super(key: key);

  @override
  State<TeamAltius> createState() => _TeamAltiusState();
}

class _TeamAltiusState extends State<TeamAltius> {
  double topContainer = 0;

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      double value = _controller.offset / 120;

      setState(() {
        topContainer = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final client = ApiClient.create();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Team Altius"),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: black,
      body: Stack(
        children: [
          getGradient(),
          Container(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: client.getTeam(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Contacts> contacts = snapshot.data.getTeam().toList();
                  contacts = contacts.reversed.toList();
                  return ListView.builder(
                    // reverse: true,
                    physics: BouncingScrollPhysics(),
                    controller: _controller,
                    itemCount: contacts.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      double scale = 1.0;
                      if (topContainer > 0.5) {
                        scale = index + 0.5 - topContainer;
                        if (scale < 0) {
                          scale = 0;
                        } else if (scale > 1) {
                          scale = 1;
                        }
                      }
                      return Opacity(
                        opacity: scale,
                        child: Transform(
                          transform: Matrix4.identity()..scale(scale, scale),
                          alignment: Alignment.bottomCenter,
                          child: ContactCard(contact: contacts[index]),
                        ),
                      );
                    },
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: LoadingAnimationWidget.dotsTriangle(
                          color: white, size: 200),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Contacts contact;
  const ContactCard({
    Key key,
    this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 5,
      shadowColor: glowColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeamDetail(
                contacts: contact,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: white,
            boxShadow: [
              BoxShadow(
                color: glowColor,
                offset: Offset(0.0, 1.0),
                blurRadius: 10.0,
              ),
            ],
          ),
          height: 100,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/altius.png'),
                    radius: 30,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Text(
                      contact.section,
                      style: h2.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: black.withOpacity(0.7)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
