import 'package:flutter/material.dart';
import 'package:techapp/models/data.dart';
import 'package:techapp/screens/components/style.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:techapp/widgets/eventList.dart';

class EventsByCategory extends StatelessWidget {
  final EventCategory eventCategory;

  const EventsByCategory({Key? key, required this.eventCategory})
      : assert(eventCategory != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                // image container
                Hero(
                  tag: eventCategory.categoryName,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(eventCategory.iconImage),
                          fit: BoxFit.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // text astronomy
                Text(
                  eventCategory.categoryName + ' Events',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 30,
                    color: black,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
                // events text

                EventsByCategoryWidget(
                    categoryName: eventCategory.categoryName,
                    categoryImage: eventCategory.iconImage),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
