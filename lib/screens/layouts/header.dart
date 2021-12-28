import 'package:flutter/material.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/pages/chatbot.dart';
import 'package:techapp/screens/pages/event_detail.dart';
import '../components/style.dart';
import '../../screens/components/style.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                FetchDataProvider.notification
                    ? Icons.notifications
                    : Icons.menu,
                size: 30,
                color: white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            Text(
              "  Altius",
              style: TextStyle(
                color: white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              child: Row(children: [
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: DataSearch());
                  },
                  icon: Icon(
                    Icons.search,
                    size: 30,
                    color: white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatBotWidget()));
                  },
                  icon: Icon(
                    Icons.question_answer,
                    size: 30,
                    color: white,
                  ),
                )
              ],),
            ),
          ],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final recentSearches = [
    "Search for events Names",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(
            Icons.clear,
            size: 30,
            color: white,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something

    final allEvents = FetchDataProvider.allEvents;
    // event names list
    final allEventNames = allEvents.map((event) => event.eventName).toList();
    // event categories list
    final allEventCategories =
        allEvents.map((event) => event.eventCategory).toList();

    final suggestionList = query.isEmpty
        ? recentSearches
        : allEventNames
            .where((element) =>
                element!.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          final String eventName = suggestionList[index]!;

          final String eventCategory =
              allEventCategories[allEventNames.indexOf(suggestionList[index])]!;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailWidget(
                eventName: eventName,
                eventCategory: eventCategory,
              ),
            ),
          );
        },
        leading: Icon(Icons.category),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index]!.substring(0, query.length),
            style: TextStyle(color: black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: suggestionList[index]!.substring(query.length),
                  style: TextStyle(color: grey))
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
