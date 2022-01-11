// ignore_for_file: import_of_legacy_library_into_null_safe
// @dart=2.9

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/models/Speaker.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
// ignore: must_be_immutable

class SpeakersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = ApiClient.create();
    return FutureBuilder(
      future: client.getLectures(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final errormessage = (snapshot.error as DioError).error.toString();
          print(errormessage);
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
            //shrinkWrap: true,
            itemCount: speakers.length,
            scrollDirection: Axis.vertical,
            //padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return ListItem(item: speakers[index]);
            },
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: LoadingAnimationWidget.staggeredDotWave(
                  color: white, size: 150),
            ),
          );
        }
      },
    );
  }
}

//Design-1 for guest lecture page:-
// class ListItem extends StatefulWidget {
//   final Speaker item;

//   const ListItem({Key key, this.item}) : super(key: key);
//   @override
//   ListItemState createState() => ListItemState();
// }

// class ListItemState extends State<ListItem> {
//   //final Speaker item;

//   //ListItemState(this.item);
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       ListView(physics: ClampingScrollPhysics(), shrinkWrap: true, children: [
//         SlimyCard(
//           width: MediaQuery.of(context).size.width * 0.9,
//           topCardHeight: 160,
//           bottomCardHeight: 300,
//           color: Color(0xFFC7C6CB),
//           topCardWidget: _buildFrontWidget(),
//           bottomCardWidget: _buildInnerWidget(),
//         ),
//       ]),
//       SizedBox(height: 20.0)
//     ]);
//   }

//   Widget _buildFrontWidget() {
//     return Builder(
//       builder: (BuildContext context) {
//         return Container(
//           alignment: Alignment.center,
//           child: Row(children: [
//             Column(children: [
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(25.0),
//                   //radius: 35.0,
//                   //backgroundColor: const Color(0xff47455f),
//                   child: Image.network(
//                     '${widget.item.imageurl}',
//                     fit: BoxFit.fill,
//                     width: 100,
//                     height: 100,
//                   ),
//                 ),
//               ),
//             ]),
//             Expanded(
//               flex: 1,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(8.0, 12, 8, 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AutoSizeText(
//                       '${widget.item.name}',
//                       style: TextStyle(
//                         fontSize: 35.0,
//                         //color:Colors.white,
//                       ),
//                       maxLines: 1,
//                     ),
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                     Column(
//                       //mainAxisAlignment: MainAxisAlignment.end,
//                       //crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Row(children: [
//                           Icon(Icons.calendar_today_outlined),
//                           SizedBox(width: 4.0),
//                           Text('${widget.item.date}',
//                               style: TextStyle(
//                                 fontSize: 20.0,
//                                 //color: Colors.white,
//                               )),
//                         ]),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(children: [
//                           Icon(Icons.alarm_on),
//                           SizedBox(width: 4.0),
//                           Text('${widget.item.time}',
//                               style: TextStyle(
//                                 fontSize: 20.0,
//                                 //color: Colors.white,
//                               )),
//                         ]),
//                         SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ]),
//         );
//       },
//     );
//   }

//   Widget _buildInnerWidget() {
//     return Builder(
//       builder: (context) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(25),
//           child: Container(
//               color: Colors.white,
//               alignment: Alignment.topCenter,
//               padding: EdgeInsets.all(10),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Text('${widget.item.desc}',
//                     style: TextStyle(fontSize: 15.0, color: Colors.black)),
//               )),
//         );
//       },
//     );
//   }
// }

//Design 2 for guest lecture page-
class ListItem extends StatelessWidget {
  final Speaker item;

  const ListItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleFoldingCell.create(
      frontWidget: _buildFrontWidget(),
      innerWidget: _buildInnerWidget(),
      cellSize: Size(MediaQuery.of(context).size.width, 170),
      //padding: EdgeInsets.all(15),
      animationDuration: Duration(milliseconds: 200),
      borderRadius: 10,
      onOpen: () => print('cell opened'),
      onClose: () => print('cell closed'),
    );
  }

  Widget _buildFrontWidget() {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Stack(children: [
            Column(children: [
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF3F51B5),
                    radius: 45.0,
                    child: CircleAvatar(
                      radius: 42.0,
                      backgroundImage: NetworkImage('${item.imageurl}'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          '${item.name}',
                          style: h1.copyWith(
                            fontSize: 30.0,
                            color: Color(0xFF3F51B5),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ]),
                )
              ]),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(15),
                color: Color(0xFF3F51B5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.calendar_today_outlined, color: white),
                        SizedBox(width: 8.0),
                        Text('${item.date}',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: white,
                              fontWeight: FontWeight.bold,
                              //color: Colors.white,
                            )),
                      ],
                    ),
                    Row(children: [
                      Icon(Icons.alarm_on, color: white),
                      SizedBox(width: 8.0),
                      Text('${item.time}',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: white,
                            fontWeight: FontWeight.bold,
                            //color: Colors.white,
                          )),
                    ])
                  ],
                ),
              )
            ]),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: white,
                ),
                onPressed: () {
                  final foldingCellState =
                      context.findAncestorStateOfType<SimpleFoldingCellState>();
                  foldingCellState?.toggleFold();
                },
              ),
            ),
          ]),
        );
      },
    );
  }

  Widget _buildInnerWidget() {
    return Builder(
      builder: (context) {
        return Container(
          color: Color(0xFF3F51B5).withOpacity(0.7),
          padding: EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text('${item.name}  ',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 8.0,
                ),
                Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: AutoSizeText(
                        '${item.desc}',
                        style: h4s,
                        maxLines: 14,
                      ),
                    )),
                SizedBox(height: 5.0)
              ]),
              Positioned(
                right: 0,
                bottom: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_upward_sharp,
                    color: white,
                  ),
                  onPressed: () {
                    final foldingCellState = context
                        .findAncestorStateOfType<SimpleFoldingCellState>();
                    foldingCellState?.toggleFold();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
