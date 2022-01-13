// ignore_for_file: import_of_legacy_library_into_null_safe
// @dart=2.9

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/models/Speaker.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/widgets/SpeakerCardCustom.dart';

class SpeakersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = ApiClient.create();
    return FutureBuilder(
      future: client.getLectures(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final errormessage = (snapshot.error as DioError).error.toString();
          debugPrint(errormessage);
          return Center(
            child: Text(
              errormessage ?? "Error",
              style: h1s,
            ),
          );
        }
        if (snapshot.hasData) {
          List<Speaker> speakers = snapshot.data.getLectures();
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: speakers.length,
            scrollDirection: Axis.vertical,
            //padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return GuestCardCustom(speaker: speakers[index]);
            },
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: glowColor.withOpacity(0.5), size: 150),
            ),
          );
        }
      },
    );
  }
}
