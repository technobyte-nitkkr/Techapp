import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/widgets/SmartButton.dart';
import 'package:techapp/widgets/event_poster.dart';
import 'package:avatar_glow/avatar_glow.dart';

DateFormat dateFormat = DateFormat("MMMM dd,yyyy HH:mm");

class Style {
  static final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
  static final smallTextStyle = commonTextStyle.copyWith(
    fontSize: 11.0,
  );
  static final commonTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 16.0,
      fontWeight: FontWeight.w400);
  static final titleTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w600);
  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w400);
}

class EventDetailWidget extends StatelessWidget {
  final Event item;
  const EventDetailWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("widget build");
    bool isflagship = (item.flagship.toString() == "true") ? true : false;
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
          constraints: new BoxConstraints.expand(),
          color: gradientStartColor2,
          child: Stack(
            children: [
              Container(
                child: SingleChildScrollView(
                  child: new Stack(
                    children: <Widget>[
                      getBackground(this.item),
                      getGradient3(),
                      getContent(this.item, context, isflagship),
                    ],
                  ),
                ),
              ),
              getRegisterButton(this.item, context, isflagship)
            ],
          ),
        ));
  }
}

Container getRegisterButton(Event item, BuildContext context, bool isflagship) {
  return (!isflagship)
      ? new Container(
          margin: EdgeInsets.fromLTRB(
              10, MediaQuery.of(context).size.height - 100, 10, 10),
          alignment: Alignment.center,
          child: SmartButtonWidget(
              eventName: item.eventName, eventCategory: item.eventCategory))
      : Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: AvatarGlow(
                  animate: true,
                  glowColor: Colors.amber,
                  endRadius: 30.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 0.0,
                    type: MaterialType.card,
                    child: Icon(
                      Icons.star,
                      size: 35,
                      color: Colors.amber[700],
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(
                      10, MediaQuery.of(context).size.height - 180, 10, 10),
                  alignment: Alignment.center,
                  child: SmartButtonWidget(
                      eventName: item.eventName,
                      eventCategory: item.eventCategory))
            ],
          ),
        );
}

Container getBackground(Event item) {
  return new Container(
    child: ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: new Image.asset(
        'assets/images/categories/' + item.eventCategory.toLowerCase() + '.png',
        fit: BoxFit.cover,
        height: 300.0,
      ),
    ),
    constraints: new BoxConstraints.expand(height: 300.0),
  );
}

Container getGradient3() {
  return Container(
    margin: new EdgeInsets.only(top: 190.0),
    height: 130.0,
    decoration: new BoxDecoration(
      gradient: new LinearGradient(
        colors: <Color>[gradientStartColor, gradientStartColor2],
        stops: [0.0, 0.9],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(0.0, 1.0),
      ),
    ),
  );
}

Container getContent(Event item, BuildContext context, bool isflagship) {
  return new Container(
    child: new ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
                  margin: const EdgeInsets.only(top: 40.0),
                  constraints: new BoxConstraints.expand(),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 100.0,
                      ),
                      new Container(height: 4.0),
                      new Container(
                          child: AutoSizeText(
                        item.eventName,
                        style: Style.titleTextStyle,
                        maxLines: 1,
                      )),
                      if (isflagship)
                        new Container(
                            child: AutoSizeText(
                          '( Flagship Event )',
                          style: TextStyle(
                              fontSize: 5,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber),
                          maxLines: 1,
                        )),
                      new Container(height: 10.0),
                      new Text(item.eventCategory,
                          style: Style.commonTextStyle),
                      Container(
                          margin: new EdgeInsets.symmetric(vertical: 8.0),
                          width: 18.0,
                          color: new Color(0xff00c6ff)),
                      Text(
                          "Start Time: " +
                              dateFormat.format(
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      item.startTime * 1000,
                                      isUtc: false)),
                          style: Style.commonTextStyle),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                          "End Time: " +
                              dateFormat.format(
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      item.endTime * 1000)),
                          style: Style.commonTextStyle),
                    ],
                  ),
                ),
                height: 300,
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
                child: GestureDetector(
                  child: new Hero(
                    tag: item.eventName,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: isflagship ? Colors.amber : Colors.transparent,
                          width: 5,
                        )),
                        width: 200.0,
                        height: 200.0,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/technologo.png',
                          image: item.file,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Image.asset('assets/images/technologo.png',
                                  fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return EventPosterWidget(
                            item: item,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 32.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text("Description", style: Style.headerTextStyle),
              Container(
                  margin: new EdgeInsets.symmetric(vertical: 5.0),
                  height: 2.0,
                  width: 18.0,
                  color: Colors.purple[800]),
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
                    margin: new EdgeInsets.symmetric(vertical: 5.0),
                    height: 2.0,
                    width: 18.0,
                    color: Colors.purple[800]),
                Column(
                    children: item.rules.map((rule) => ruleItem(rule)).toList())
              ],
            ),
          ),
        if (item.rules.length > 0)
          Container(
            height: 20,
          ),
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 32.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text("Venue", style: Style.headerTextStyle),
              Container(
                  margin: new EdgeInsets.symmetric(vertical: 5.0),
                  height: 2.0,
                  width: 18.0,
                  color: Colors.purple[800]),
              Container(child: Text(item.venue, style: Style.commonTextStyle))
            ],
          ),
        ),
        Container(height: 20),
        if (item.cordinators.length > 0)
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Coordinators", style: Style.headerTextStyle),
                Container(
                    margin: new EdgeInsets.symmetric(vertical: 5.0),
                    height: 2.0,
                    width: 18.0,
                    color: Colors.purple[800]),
              ],
            ),
          ),
        if (item.cordinators.length > 0)
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 30.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: item.cordinators.length,
              padding: EdgeInsets.all(0),
              itemBuilder: (BuildContext ctx, int index) {
                return cordinatorItem(item.cordinators[index]);
              },
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 65,
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
            ),
          ),
        if (item.cordinators.length > 0) Container(height: 60)
      ],
    ),
  );
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
    ),
  );
}

Widget cordinatorItem(Cordinators cordinator) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.purple[200],
                onPrimary: Colors.white,
                shadowColor: Colors.black,
                elevation: 5,
                shape: (RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ))),
            onPressed: () async {
              var number = cordinator.coordinator_number;
              if (!await launch('tel:$number')) {
                print(cordinator.coordinator_name);
              }
            },
            child: AutoSizeText(
              cordinator.coordinator_name,
              style: TextStyle(
                fontSize: 18,
              ),
              maxLines: 1,
            )),
      ));
}
