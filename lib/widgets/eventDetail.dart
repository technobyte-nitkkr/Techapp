import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:techapp/models/EventByCategories.dart';
import 'package:techapp/models/data.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';

class Style {
  static final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
  static final smallTextStyle = commonTextStyle.copyWith(
    fontSize: 9.0,
  );
  static final commonTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 14.0,
      fontWeight: FontWeight.w400);
  static final titleTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.w600);
  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w400);
}

class EventDetailWidget extends StatelessWidget {
  EventDetailWidget({Key? key, required this.item, required this.cimage})
      : super(key: key);

  final Event item;
  final String cimage;
  final _trackingScrollController = TrackingScrollController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: gradientEndColor,
        child: new Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }

  Container _getBackground() {
    return new Container(
      child: new Image.asset(
        cimage,
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: new BoxConstraints.expand(height: 295.0),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[gradientStartColor, gradientEndColor],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getContent() {
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          Container(
              margin: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0,
              ),
              child: new Stack(
                children: <Widget>[
                  Container(
                    child: Container(
                      margin: new EdgeInsets.fromLTRB(16.0, 42.0, 16.0, 16.0),
                      constraints: new BoxConstraints.expand(),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 40.0,
                          ),
                          new Container(height: 4.0),
                          new Text(item.eventName, style: Style.titleTextStyle),
                          new Container(height: 10.0),
                          new Text(item.eventCategory,
                              style: Style.commonTextStyle),
                          Container(
                              margin: new EdgeInsets.symmetric(vertical: 8.0),
                              width: 18.0,
                              color: new Color(0xff00c6ff)),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                  flex: 0,
                                  child: Container(
                                    child: new Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text("Start Time: ",
                                              style: Style.commonTextStyle),
                                          new Container(width: 8.0),
                                          // new Text(
                                          //     DateTime.fromMicrosecondsSinceEpoch(
                                          //             int.parse(
                                          //                     item.startTime) *
                                          //                 1000)
                                          //         .toString(),
                                          //     style: Style.commonTextStyle),
                                        ]),
                                  )),
                              new Container(
                                width: 32.0,
                              ),
                              new Expanded(
                                  flex: 0,
                                  child: Container(
                                    child: new Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text("End Time: ",
                                              style: Style.commonTextStyle),
                                          new Container(width: 8.0),
                                          // new Text(item.endTime,
                                          //     style: Style.commonTextStyle),
                                        ]),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    height: 200.0,
                    margin: new EdgeInsets.only(top: 72.0),
                    decoration: new BoxDecoration(
                      color: new Color(0xFF333366),
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.circular(8.0),
                      boxShadow: <BoxShadow>[
                        new BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: new Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // margin: new EdgeInsets.symmetric(vertical: 16.0),
                    alignment: FractionalOffset.center,
                    child: new Hero(
                        tag: item.eventName,
                        child: Container(
                            width: 250.0,
                            height: 150.0,
                            child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/technologo.png',
                                image: item.file,
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) => Image.asset(
                                        'assets/images/technologo.png')))),
                  ),
                ],
              )),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Description", style: Style.headerTextStyle),
                Container(
                    margin: new EdgeInsets.symmetric(vertical: 8.0),
                    height: 2.0,
                    width: 18.0,
                    color: new Color(0xff00c6ff)),
                new Text(item.description, style: Style.commonTextStyle),
              ],
            ),
          ),
          Container(
            height: 20,
          ),
          if (item.rules.length > 0)
            new Container(
              padding: new EdgeInsets.symmetric(horizontal: 32.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("Rules", style: Style.headerTextStyle),
                  Container(
                      margin: new EdgeInsets.symmetric(vertical: 8.0),
                      height: 2.0,
                      width: 18.0,
                      color: new Color(0xff00c6ff)),
                  Column(
                      children:
                          item.rules.map((rule) => ruleItem(rule)).toList())
                ],
              ),
            ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Venue", style: Style.headerTextStyle),
                Container(
                    margin: new EdgeInsets.symmetric(vertical: 8.0),
                    height: 2.0,
                    width: 18.0,
                    color: new Color(0xff00c6ff)),
                Container(child: Text(item.venue, style: Style.commonTextStyle))
              ],
            ),
          ),
          Container(height: 5),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Event Coordinators", style: Style.headerTextStyle),
                Container(
                    margin: new EdgeInsets.symmetric(vertical: 8.0),
                    height: 2.0,
                    width: 18.0,
                    color: new Color(0xff00c6ff)),
              ],
            ),
          ),
          if (item.cordinators.length > 0)
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                  children: item.cordinators
                      .map((cordinator) => cordinatorItem(cordinator))
                      .toList()),
            ),
        ],
      ),
    );
  }

  Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new BackButton(color: Colors.white),
    );
  }
}

Container ruleItem(String rule) {
  return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("• ", style: Style.commonTextStyle),
          Expanded(
            child: Text(rule, style: Style.commonTextStyle),
          ),
        ],
      ));
}

Container cordinatorItem(Cordinators cordinator) {
  return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child:
                Text(cordinator.coordinator_name, style: Style.titleTextStyle),
          ),
        ],
      ));
}
