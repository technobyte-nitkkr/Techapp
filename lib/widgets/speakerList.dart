import 'package:flutter/material.dart';
import 'package:techapp/models/Speaker.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:slimy_card/slimy_card.dart';
// ignore: must_be_immutable


//
class SpeakersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FetchDataProvider.speakers.length == 0)
      return Center(
        child: CircularProgressIndicator(),
      );
    else

      return ListView.builder(
        //shrinkWrap: true,
        itemCount: FetchDataProvider.speakers.length,
        scrollDirection: Axis.vertical,
        //padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return ListItem(item: FetchDataProvider.speakers[index]);
        },
      );
  }
}
// Design-1 for guest lecture page:-
// class ListItem extends StatefulWidget{
//   final Speaker item;
//
//   const ListItem({Key? key, required this.item}) : super(key: key);
//   @override
//   ListItemState createState() => ListItemState();
//
// }
// class ListItemState extends State<ListItem>{
//   //final Speaker item;
//
//   //ListItemState(this.item);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children:[
//         ListView(
//             physics: ClampingScrollPhysics(),
//             shrinkWrap:true,
//             children:[
//               SlimyCard(
//                 width:MediaQuery.of(context).size.width*0.9,
//                 topCardHeight: 160,
//                 bottomCardHeight: 300,
//                 color: Color(0xFFC7C6CB),
//                 topCardWidget:_buildFrontWidget(),
//                 bottomCardWidget: _buildInnerWidget(),
//               ),
//             ]
//         ),
//         SizedBox(height:20.0)
//       ]
//
//     );
//
//   }
//
//   Widget _buildFrontWidget() {
//     return Builder(
//       builder: (BuildContext context) {
//         return Container(
//           alignment: Alignment.center,
//           child: Row(
//               children:[
//                 Column(
//                     children:[
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(25.0),
//                           //radius: 35.0,
//                           //backgroundColor: const Color(0xff47455f),
//                           child: Image.network('${widget.item.imageurl}',
//                             fit: BoxFit.fill,
//                             width: 100,
//                             height: 100,       ),
//
//                         ),
//                       ),
//                     ]
//                 ),
//                 Expanded(
//                     flex:1,
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(8.0,12,8,8),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children:[
//                             Text(
//                                 '${widget.item.name}',
//                                 overflow:TextOverflow.ellipsis ,
//                                 style:TextStyle(
//                                   fontSize: 35.0,
//                                   //color:Colors.white,
//
//
//                                 )),
//                             SizedBox(height: 10.0,),
//                             Row(
//                               //mainAxisAlignment: MainAxisAlignment.end,
//                               //crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children:[
//                                 Icon(Icons.calendar_today_outlined),
//                                 SizedBox(width:4.0),
//                                 Text('${widget.item.date}',
//                                     style:TextStyle(
//                                       fontSize: 20.0,
//                                       //color: Colors.white,
//
//                                   )
//                                 ),
//                                 SizedBox(width:30.0),
//                                 Icon(Icons.alarm_on),
//                                 SizedBox(width:4.0),
//                                 Text('${widget.item.time}',
//                                     style:TextStyle(
//                                       fontSize: 20.0,
//                                       //color: Colors.white,
//                                     )
//                                 ),
//
//                               ],
//                             ),
//                           ]
//                       ),
//                     )
//                 )
//               ]
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildInnerWidget() {
//     return Builder(
//       builder: (context) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(25),
//           child: Container(
//             color:Colors.white,
//             alignment: Alignment.topCenter,
//             padding: EdgeInsets.all(10),
//               child:SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Text(
//                     '${widget.item.desc}',
//                     style:TextStyle(
//                       fontSize: 15.0,
//                       color: Colors.black
//                     )
//                 ),
//               )
//
//           ),
//         );
//       },
//     );
//   }
//
// }

//Design 2 for guest lecture page-
class ListItem extends StatelessWidget {
  final Speaker item;

  const ListItem({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleFoldingCell.create(
      frontWidget: _buildFrontWidget(),
      innerWidget: _buildInnerWidget(),
      cellSize: Size(MediaQuery.of(context).size.width, 165),
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
          color: Color(0xFFDDDDE0),
          alignment: Alignment.center,
          child: Stack(
            children:[
              Padding(
                padding: const EdgeInsets.fromLTRB(5,10,0,0),
                child: Row(
                    children:[
                      Column(
                          children:[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 40.0,
                                child: CircleAvatar(
                                  radius: 38.0,
                                  //backgroundColor: const Color(0xff47455f),
                                  backgroundImage: NetworkImage('${item.imageurl}'),

                                ),
                              ),
                            ),
                          ]
                      ),
                      Expanded(
                          flex:1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Text(
                                      '${item.name}',
                                      style:TextStyle(
                                        fontSize: 35.0,
                                        overflow:TextOverflow.ellipsis


                                      )),
                                  SizedBox(height: 10.0,),
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.end,
                                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children:[
                                      Icon(Icons.calendar_today_outlined),
                                      SizedBox(width:8.0),
                                      Text('${item.date}',
                                      style:TextStyle(
                                        fontSize: 20.0,
                                        //color: Colors.white,

                                        )
                                      ),



                                    ],
                                  ),
                                  SizedBox(height:10.0),
                                  Row(
                                    children:[
                                      Icon(Icons.alarm_on),
                                      SizedBox(width:8.0),
                                      Text('${item.time}',
                                          style:TextStyle(
                                            fontSize: 20.0,
                                            //color: Colors.white,
                                          )
                                      ),

                                    ]
                                  )
                                ]
                            ),
                          )
                      )
                    ]
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon:const Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    final foldingCellState = context.findAncestorStateOfType<SimpleFoldingCellState>();
                    foldingCellState?.toggleFold();
                  },

                ),
              ),
            ]
          ),
        );
      },
    );
  }

  Widget _buildInnerWidget() {
    return Builder(
      builder: (context) {
        return Container(
          color: Color(0xFFC7C6CB),
          padding: EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(
                        '${item.name}  ',
                        style:TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,

                        )),
                    SizedBox(height: 5.0,),
                    Expanded(
                      flex:1,
                      child:SingleChildScrollView(
                        child: Text(
                            '${item.desc}',
                          style:TextStyle(
                            fontSize: 15.0,
                          )
                        ),
                      )
                    ),
                    SizedBox(height:5.0)
                  ]

              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_upward_sharp),
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
