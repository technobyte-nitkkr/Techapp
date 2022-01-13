import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/pages/chatbot.dart';
import 'package:techapp/screens/pages/notifications.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:techapp/screens/pages/search_event_detail.dart';
import 'package:techapp/screens/widgets/notification_icon.dart';
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
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                    color: white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                NamedIcon(
                  iconData: Icons.notifications,
                  size: 30,
                  color: white,
                  notificationCount: FetchDataProvider.notification,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationsWidget()));
                  },
                ),
              ],
            ),
            Text("  Altius", style: h2s),
            Container(
              child: Row(
                children: [
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
                  AvatarGlow(
                    endRadius: 25,
                    glowColor: glowColor,
                    duration: Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatBotWidget()));
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.robot,
                        size: 25,
                        color: white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final recentSearches = [
    "Search for Event Names",
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
            color: grey,
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

    return Stack(
      children: [
        getGradient(),
        Container(
          color: Colors.transparent,
          child: ListView.builder(
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                final String eventName = suggestionList[index]!;

                final String eventCategory = allEventCategories[
                    allEventNames.indexOf(suggestionList[index])]!;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchEventDetail(
                      eventName: eventName,
                      eventCategory: eventCategory,
                    ),
                  ),
                );
              },
              leading: Icon(Icons.category, color: white),
              title: RichText(
                text: TextSpan(
                  text: suggestionList[index]!.substring(0, query.length),
                  style: h3s,
                  children: [
                    TextSpan(
                        text: suggestionList[index]!.substring(query.length),
                        style: h3s)
                  ],
                ),
              ),
            ),
            itemCount: suggestionList.length,
          ),
        ),
      ],
    );
  }
}
