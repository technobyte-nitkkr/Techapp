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
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child:GridView.count(
            crossAxisCount: 2,
            childAspectRatio: .85,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: FetchDataProvider.contacts.map<Widget>((contact) =>
              Card(
                child: InkWell(
                  onTap: (){
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
                                MediaQuery.of(context).size.height * 0.7,
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
                              }
                            )
                          ),
                        );
                      }
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        backgroundImage:AssetImage('assets/images/technologo.png'),
                        radius: 40,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(contact.section,
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).toList(),
          ),
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
