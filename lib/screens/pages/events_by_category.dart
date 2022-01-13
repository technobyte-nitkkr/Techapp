import 'package:flutter/material.dart';
import 'package:techapp/models/categories.dart';
import 'package:techapp/screens/components/style.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:techapp/screens/widgets/event_list.dart';

class EventsByCategory extends StatelessWidget {
  final CategorySchema categoryName;

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
                      opacity: 0.9,
                      image: NetworkImage(categoryName.imgUrl),
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
                  categoryName.categoryName.substring(0, 1).toUpperCase() +
                      categoryName.categoryName.substring(1),
                  style: h1s,
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
