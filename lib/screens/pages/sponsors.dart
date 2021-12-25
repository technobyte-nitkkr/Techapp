import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/widgets/sponsorList.dart';

class Sponsors extends StatelessWidget {
  Sponsors({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 20.0, left: 20.0),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Our Sponsors',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 30,
                    color: white,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,  // TODO: Not working
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
              ),
              Expanded(
                  child: SponsorsWidget(),
              ),
            ],
            ),
        )
        
        // SingleChildScrollView(
        //   padding: EdgeInsets.all(30),
        //   child: Column(
        //     children: [
        //       Scrollbar(
        //           controller: _trackingScrollController,
        //           isAlwaysShown: true,
        //           child: SingleChildScrollView(
        //               scrollDirection: Axis.horizontal,
        //               controller: _trackingScrollController,
        //               dragStartBehavior: DragStartBehavior.start,
        //               child: Text(
        //                 "Sponsors",
        //                 style: TextStyle(
        //                   color: white,
        //                   fontSize: 60,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ))),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
