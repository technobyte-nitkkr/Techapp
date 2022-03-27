// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:techapp/models/section.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/team_details.dart';
import 'package:techapp/screens/widgets/shimmeritem.dart';

class Teamtechspardha extends StatefulWidget {
  Teamtechspardha({
    Key key,
  }) : super(key: key);

  @override
  State<Teamtechspardha> createState() => _TeamtechspardhaState();
}

class _TeamtechspardhaState extends State<Teamtechspardha> {
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
        title: Text("Team Techspardha"),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: black,
      body: Stack(
        children: [
          getGradient(context),
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
                    physics: ClampingScrollPhysics(),
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
                  return Column(
                    children: [
                      ShimmerBuilder(
                        title: true,
                        imageheight: 60,
                        subtitle: false,
                      ),
                    ],
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
          decoration: boxDecoration.copyWith(
            borderRadius: BorderRadius.circular(20.0),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/techspardha.png',
                      height: 60,
                      width: 60,
                      imageCacheWidth: 1000,
                      fit: BoxFit.cover,
                      image: contact.logo,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/techspardha.png',
                            height: 60, width: 60, fit: BoxFit.cover);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: AutoSizeText(
                      contact.section,
                      style: h2.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: white.withOpacity(0.8)),
                      maxLines: 1,
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
