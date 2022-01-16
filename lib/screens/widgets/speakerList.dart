// @dart=2.9

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/models/Speaker.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/widgets/SpeakerCardCustom.dart';

class SpeakersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Speaker> speakers = FetchDataProvider.speakers;
    if (speakers.length > 0) {
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
          child:
              LoadingAnimationWidget.staggeredDotsWave(color: white, size: 150),
        ),
      );
    }
  }
}
