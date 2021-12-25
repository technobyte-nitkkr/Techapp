import 'dart:convert';

import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:techapp/models/Sponsor.dart';
import 'package:techapp/screens/components/style.dart';

class SponsorsWidget extends StatefulWidget {
  
  const SponsorsWidget(
      {Key? key, })
      : super(key: key);

  @override
  State<SponsorsWidget> createState() => _SponsorsWidgetState();
}

class _SponsorsWidgetState extends State<SponsorsWidget> {
  
  List<Sponsor> sponsors = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    // await Future.delayed(Duration(seconds: 2));
    final url =
        'https://us-central1-techspardha-87928.cloudfunctions.net/api/foodsponsors';
    final response = await http.get(Uri.parse(url));
    // print(url);
    // print(response.body);
    final data = json.decode(response.body);
    final sponsorsJSON = data['data']['foodSponsors'].cast<Map<String, dynamic>>();
    // print(sponsorsJSON);

    // EventList.events = 
    //     events.map<Event>((json) => Event.fromJson(json)).toList();

    setState(() {
      sponsors = sponsorsJSON.map<Sponsor>((json) => Sponsor.fromJson(json)).toList();
      for(var s in sponsors) {
        print (s.name);
      }
      print("done");
    });
  }

  @override
  void dispose() {
    sponsors = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (sponsors.length == 0)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return ListView.builder(
            shrinkWrap: true,
            itemCount: sponsors.length,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return ListItem(item: sponsors[index]);
            });
  }
}

class ListItem extends StatelessWidget {
  final Sponsor item;

  const ListItem({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print (item.name);
    return Card(   // TODO: add shadow on all sides
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)
                ),
                color: white,
                child: Container(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          topLeft: Radius.circular(32)
                        ),
                        child: Image.network('${item.imageurl}'),
                      ),
                      Expanded(
                        child: Text(
                        '${item.name}',
                        style: TextStyle (
                          fontFamily: 'Avenir',
                          color: const Color(0xff47455f),
                          fontWeight: FontWeight.w900,
                          fontSize: 26
                        ),
                        textAlign: TextAlign.left, // TODO: Not working
                      ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
