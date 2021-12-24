import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:techapp/models/data.dart';
import 'package:techapp/screens/pages/events_by_category.dart';
import '../components/style.dart';
import '../../controllers/MenuController.dart';
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
                Icons.menu,
                size: 30,
                color: white,
              ),
              onPressed: context.read<MenuController>().controlMenu,
            ),
            Text(
              "  Altius",
              style: TextStyle(
                color: white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                },
                icon: Icon(
                  Icons.search,
                  size: 30,
                  color: white,
                ))
          ],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final categoriesListFinal = [
    "astronomy",
    "design",
    "informals",
    "managerial",
    "online-Events",
    "papyrus-Vitae",
    "programming",
    "quizzes",
    "robotics"
  ];

  final recentSearches = [
    "online-Events",
    "papyrus-Vitae",
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
    // show some result based on the selection
    return Scaffold();
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>
    //             EventsByCategory(eventCategory: categories[])));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentSearches
        : categoriesListFinal
            .where((element) => element.startsWith(query))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.category),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style: TextStyle(color: black, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: grey))
            ])),
      ),
      itemCount: suggestionList.length,
    );
  }
}
