import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:techapp/screens/widgets/sponsor_list.dart';

class Sponsors extends StatelessWidget {
  Sponsors({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: Container(
          child: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 20.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                'Our Sponsors',
                textAlign: TextAlign.center,
                style: Pagelabel,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SponsorsWidget(),
            SizedBox(
              height: 40,
            )
          ],
        ),
      )),
    );
  }
}
