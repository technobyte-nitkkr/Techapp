import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:techapp/widgets/event_list.dart';

class EventsByCategory extends StatelessWidget {
  final String categoryName;

  const EventsByCategory({Key? key, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: grey,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Stack(
          children: [
            getGradient(),
            Hero(
              tag: categoryName,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                      image: AssetImage('assets/images/categories/' +
                          categoryName.toLowerCase() +
                          '.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Column(
              children: [
                // image container
                SizedBox(
                  height: 160,
                ),
                // text astronomy
                Text(
                  categoryName,
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 30,
                    color: white,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
                // events text
                SizedBox(
                  height: 10,
                ),

                EventsByCategoryWidget(
                  categoryName: categoryName,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
