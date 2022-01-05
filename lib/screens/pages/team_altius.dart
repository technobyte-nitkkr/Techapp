// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:techapp/models/section.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/layouts/page_layout.dart';

class TeamAltius extends StatelessWidget {
  TeamAltius({
    Key key,
  }) : super(key: key);

  // final _trackingScrollController = TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return PageLayout(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
          future: client.getTeam(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Contacts> contacts = snapshot.data.getTeam();
              return GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: .85,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: contacts.reversed
                    .map<Widget>(
                      (contact) => Card(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Center(
                                    child: Text(
                                      contact.section,
                                      style: TextStyle(
                                        fontSize: 30.0,
                                      ),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  elevation: 16,
                                  content: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      width: 400.0,
                                      alignment: Alignment.center,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: contact.people.length,
                                          itemBuilder: (context, id) {
                                            return buildwid(
                                                contact.people[id].imageUrl,
                                                contact.people[id].name,
                                                contact.people[id].post);
                                          })),
                                );
                              },
                            );
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/technologo.png'),
                                radius: 40,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                contact.section,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget buildwid(String imageUrl, String name, String post) {
  return Container(
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        ClipOval(
          child: FadeInImage.assetNetwork(
            height: 130,
            width: 130,
            placeholder: 'assets/images/technologo.png',
            image: imageUrl,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) => Image.asset(
              'assets/images/technologo.png',
              height: 130.0,
              width: 130.0,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        AutoSizeText(
          name.toUpperCase(),
          style: TextStyle(
            letterSpacing: 1.0,
            fontSize: 25.0,
          ),
          maxLines: 1,
        ),

        SizedBox(
          height: 10.0,
        ),
        Text(
          post.toUpperCase(),
          style: TextStyle(fontSize: 15.0),
        ),
        SizedBox(
          height: 20.0,
        ),
        // Spacer(),
      ],
    ),
  );
}
