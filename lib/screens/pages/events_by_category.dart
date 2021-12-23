import 'package:flutter/material.dart';
import 'package:techapp/models/data.dart';
import 'package:techapp/screens/components/style.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:techapp/widgets/eventList.dart';

class EventsByCategory extends StatelessWidget {
  final EventCategory eventCategory;

  Container _getGradient2() {
    return new Container(
      // margin: new EdgeInsets.only(top: 30.0),
      height: 150.0,
      decoration: new BoxDecoration(
        // border: new Border.all(
        //   color: Colors.white,
        //   width: 10.0,
        // ),
        gradient: new LinearGradient(
            colors: <Color>[gradientStartColor, gradientEndColor],
            // stops: [0.0, 0.9],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
    );
  }

  const EventsByCategory({Key? key, required this.eventCategory})
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
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Stack(
          children: [
            getGradient(),
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
            _getGradient2(),
            Column(
              children: [
                // image container

                SizedBox(
                  height: 160,
                ),
                // text astronomy
                Text(
                  eventCategory.categoryName + ' Events',
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
