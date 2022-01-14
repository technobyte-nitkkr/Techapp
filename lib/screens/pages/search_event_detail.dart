// @dart=2.9
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
    final client = ApiClient.create();
    return new Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          child: FutureBuilder(
            future: client.getEvent(this.eventCategory, this.eventName),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                final errormessage =
                    (snapshot.error as DioError).error.toString();
                debugPrint(errormessage);
                return Stack(
                  children: [
                    Center(
                      child: Text(
                        // ignore: unnecessary_null_comparison
                        (errormessage.toString() == null)
                            ? 'Error'
                            : errormessage,
                        style: h2s,
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasData) {
                Event event = snapshot.data.getEvent();
                return Stack(
                  children: [
                    getGradient(),
                    SingleChildScrollView(
                      child: new Stack(
                        children: <Widget>[
                          getContent(event, context,
                              event.flagship.toString() == "true"),
                        ],
                      ),
                    ),
                    getRegisterButton(
                        event, context, event.flagship.toString() == "true")
                  ],
                );
              }
              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(children: [
                    getGradient(),
                    Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: white, size: 100),
                    ),
                  ]));
            },
          ),
        ));
  }
}
