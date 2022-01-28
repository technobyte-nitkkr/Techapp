import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/screens/widgets/SmartButton.dart';
import 'package:techapp/screens/widgets/event_poster.dart';
import 'package:avatar_glow/avatar_glow.dart';

DateFormat dateFormat = DateFormat("dd,MMMM,yyyy hh:mm a");

class EventDetailWidget extends StatelessWidget {
  final Event item;
  const EventDetailWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("widget build");
    bool isflagship = (item.flagship.toString() == "true") ? true : false;
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
          constraints: new BoxConstraints.expand(),
          child: Stack(
            children: [
              getGradient(),
              Container(
                child: SingleChildScrollView(
                  child: new Stack(
                    children: <Widget>[
                      // getBackground(this.item),
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
          child: SmartButtonWidget(event: item))
      : Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                child: AvatarGlow(
                  animate: true,
                  glowColor: glowColor,
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
                      color: glowColor,
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(
                      10, MediaQuery.of(context).size.height - 180, 10, 10),
                  alignment: Alignment.center,
                  child: SmartButtonWidget(
                    event: item,
                  ))
            ],
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
                        style: h1s.copyWith(fontSize: 23),
                        maxLines: 1,
                      )),
                      if (isflagship)
                        new Container(
                            child: AutoSizeText(
                          '( Flagship Event )',
                          style: h3.copyWith(
                            fontSize: 12,
                            color: glowColor,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1,
                        )),
                      new Container(height: 7.0),
                      new Text(
                          item.eventCategory.substring(0, 1).toUpperCase() +
                              item.eventCategory.substring(1),
                          style: h2s.copyWith(fontWeight: FontWeight.w300)),
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
                          style: h5s),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                          "End Time: " +
                              dateFormat.format(
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      item.endTime * 1000)),
                          style: h5s),
                    ],
                  ),
                ),
                height: 300,
                margin: new EdgeInsets.only(top: 72.0),
                decoration: boxDecoration.copyWith(
                  borderRadius: new BorderRadius.circular(8.0),
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
                        width: 200.0,
                        height: 200.0,
                        decoration: boxDecoration.copyWith(
                          border: Border.all(
                            color: Colors.white,
                            width: 4.0,
                          ),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/techspardha.png',
                            image: item.poster,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Image.asset('assets/images/techspardha.png',
                                    fit: BoxFit.cover),
                          ),
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
              new Text("Description", style: h2s),
              Container(
                  margin: new EdgeInsets.symmetric(vertical: 5.0),
                  height: 2.0,
                  width: 18.0,
                  color: white),
              new Text(item.description, style: h5s),
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
                new Text("Rules", style: h2s),
                Container(
                    margin: new EdgeInsets.symmetric(vertical: 5.0),
                    height: 2.0,
                    width: 18.0,
                    color: white),
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
              new Text("Venue", style: h2s),
              Container(
                  margin: new EdgeInsets.symmetric(vertical: 5.0),
                  height: 2.0,
                  width: 18.0,
                  color: white),
              Container(child: Text(item.venue, style: h6s))
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
                new Text("Coordinators", style: h2s),
                Container(
                    margin: new EdgeInsets.symmetric(vertical: 5.0),
                    height: 2.0,
                    width: 18.0,
                    color: white),
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
                mainAxisSpacing: 0,
                crossAxisSpacing: 5,
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
        Text("• ", style: h6s),
        Expanded(
          child: Text(rule, style: h6s),
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
            style: elevatedButtonStyle,
            onPressed: () async {
              var number = cordinator.coordinator_number;
              if (!await launch('tel:$number')) {
                debugPrint(cordinator.coordinator_name);
              }
            },
            child: AutoSizeText(
              cordinator.coordinator_name,
              style: h4s,
              maxLines: 1,
            )),
      ));
}
