import 'package:flutter/material.dart';
import 'package:techapp/providers/event_provider.dart';

class TeamAltius extends StatelessWidget {
  TeamAltius({
    Key? key,
  }) : super(key: key);

  // final _trackingScrollController = TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Altius'),
      ),
      body: ListView.builder(
        itemCount: FetchDataProvider.contacts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Card(
              elevation: 5.0,
              child: Container(
                decoration: BoxDecoration(color: Colors.green[100]),
                child: ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Center(
                              child: Text(FetchDataProvider.contacts[index].section,
                              style: TextStyle(
                              fontSize: 40.0,
                              color:Colors.amberAccent[200],
                              backgroundColor: Colors.blue[200]),
                              ),
                            ),
                            backgroundColor: Colors.blue[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            elevation: 16,
                            content: Container(
                                height: 1000.0,
                                width: 300.0,
                                
                                child: ListView.builder(
                                  shrinkWrap: true,
                                    itemCount: FetchDataProvider
                                        .contacts[index].people.length,
                                    itemBuilder: (context, id) {
                                      return buildwid(
                                          FetchDataProvider.contacts[index]
                                              .people[id].imageUrl,
                                          FetchDataProvider
                                              .contacts[index].people[id].name,
                                          FetchDataProvider
                                              .contacts[index].people[id].post);
                                    })),
                          );
                        });
                  },
                  title: Text(FetchDataProvider.contacts[index].section),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwii.fandom.com%2Fwiki%2FPikachu&psig=AOvVaw3YLWFDO_pNi8GDAKi7Htwc&ust=1640695397581000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCJD77OaAhPUCFQAAAAAdAAAAABAD')),
                ),
              ),
            ),
          );
        },
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
        CircleAvatar(
          radius: 80.0,
          backgroundImage: NetworkImage(imageUrl),
          backgroundColor: Colors.green[100],
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
