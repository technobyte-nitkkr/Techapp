// @dart=2.9
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/pages/event_detail.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/screens/components/style.dart';

DateFormat dateFormat = DateFormat("MMMM dd,yyyy HH:mm");

class SearchEventDetail extends StatelessWidget {
  final String eventName;
  final String eventCategory;
  SearchEventDetail({Key key, this.eventName, this.eventCategory})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return new Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          color: gradientStartColor2,
          child: FutureBuilder(
            future: client.getEvent(this.eventCategory, this.eventName),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                final errormessage = json
                    .decode((snapshot.error as DioError).response.toString());

                return Center(
                  child: Text(
                    errormessage['message'] ?? "Error",
                    style: TextStyle(color: white, fontSize: 20),
                  ),
                );
              }
              if (snapshot.hasData) {
                Event event = snapshot.data.getEvent();
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: new Stack(
                        children: <Widget>[
                          getBackground(event),
                          getGradient3(),
                          getContent(event, context),
                        ],
                      ),
                    ),
                    getRegisterButton(event, context)
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                      color: white, size: 200),
                ),
              );
            },
          ),
        ));
  }
}
