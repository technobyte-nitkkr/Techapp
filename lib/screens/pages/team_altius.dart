import 'package:flutter/material.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/layouts/page_layout.dart';

class TeamAltius extends StatelessWidget {
  TeamAltius({
    Key? key,
  }) : super(key: key);

  // final _trackingScrollController = TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: ListView.builder(
          itemCount: FetchDataProvider.contacts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Card(
                elevation: 5.0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Center(
                                child: Text(
                                  FetchDataProvider.contacts[index].section,
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
                                      MediaQuery.of(context).size.height * 0.7,
                                  width: 400.0,
                                  alignment: Alignment.center,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: FetchDataProvider
                                          .contacts[index].people.length,
                                      itemBuilder: (context, id) {
                                        return buildwid(
                                            FetchDataProvider.contacts[index]
                                                .people[id].imageUrl,
                                            FetchDataProvider.contacts[index]
                                                .people[id].name,
                                            FetchDataProvider.contacts[index]
                                                .people[id].post);
                                      })),
                            );
                          });
                    },
                    title: Text(FetchDataProvider.contacts[index].section),
                    leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/technologo.png')),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget buildwid(String imageUrl, String name, String post) {
  // print(FetchDataProvider.contacts[0].people[1].name);
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
        Text(
          name.toUpperCase(),
          style: TextStyle(
            letterSpacing: 1.0,
            fontSize: 25.0,
          ),
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
