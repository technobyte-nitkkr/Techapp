import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:techapp/screens/widgets/speakerList.dart';

class Speakers extends StatelessWidget {
  Speakers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Guest Lectures',
                  style: Pagelabel,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SpeakersWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
