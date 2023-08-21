// import 'package:flutter/material.dart';
// import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:robustremedy/screen/Item_group_screen/item_group.dart';
// import 'package:robustremedy/themes/light_color.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
//
// class TrackData {
//   final String? id;
//   final String? status;
//   final String? title;
//
//   TrackData({
//     this.id,
//     this.status,
//     this.title,
//   });
//
//   factory TrackData.fromJson(Map<String, dynamic> json) {
//     return TrackData(
//       id: json['id'],
//       status: json['status'],
//       title: json['title'],
//     );
//   }
// }
//
// class trackorder extends StatefulWidget {
//   trackorder() : super();
//
//   final String title = "";
//
//   @override
//   trackorderState createState() => trackorderState();
// }
//
// class HomePageTimelineObject {
//   final TimelineNodeStyle? style;
//   final String? message;
//   final TextStyle? textStyle;
//   final String? submsg;
//   final Icon? icon;
//
//   HomePageTimelineObject(
//       {this.style, this.message, this.textStyle, this.submsg, this.icon});
// }
//
// class trackorderState extends State<trackorder> {
//   // https://jsonplaceholder.typicode.com/users
//   var search = false;
//   var orderid;
//   final _debouncer = Debouncer(milliseconds: 500);
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Track Your Order"),
//       ),
//       body: SingleChildScrollView(
//           child: Column(
//         children: <Widget>[
//           Container(
//             height: 60,
//             decoration: BoxDecoration(color: LightColor.yellowColor),
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 12, top: 0, bottom: 12),
//                     child: Container(
//                       decoration: BoxDecoration(color: Colors.white),
//                       width: width / 1.2,
//                       child: TextField(
//                         autofocus: true,
//                         textInputAction: TextInputAction.go,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.all(15.0),
//                           hintText: "Search Order Id",
//                         ),
//                         onChanged: (string) {
//                           setState(() {
//                             orderid = string;
//                             search = true;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                       icon: const Icon(
//                         Icons.search,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           search = true;
//                         });
//                       }),
//                 ]),
//           ),
//           if (search == true)
//             (Container(
//               height: height / 1.22,
//               child: FutureBuilder<List<TrackData>>(
//                 future: _fetchTrackData(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     List<TrackData> data = snapshot.data ?? [];
//                     return Grid(context,data);
//
//                   } else if (snapshot.hasError) {
//                     return Text("${snapshot.error}");
//                   }
//                   return Center(
//                       child: CircularProgressIndicator(
//                     valueColor:
//                         AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
//                   ));
//                 },
//               ),
//             ))
//           else
//             (Container()),
//         ],
//       )),
//     );
//   }
//
//   Future<List<TrackData>> _fetchTrackData() async {
//     final jobsListAPIUrl = 'https://onlinefamilypharmacy.com/mobileapplication/trackyourorder.php';
//     var data = {'orderid': orderid};
//     var response = await http.post(Uri(path: jobsListAPIUrl), body: json.encode(data));
//
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((job) => new TrackData.fromJson(job)).toList();
//     } else {
//       throw Exception('Failed to load jobs from API');
//     }
//   }
//
//
// }
//
// final List<HomePageTimelineObject> timelineObject = [
//   HomePageTimelineObject(
//       message: 'Order Received',
//       submsg: 'Your order has been Received successfully',
//       icon: Icon(
//         Icons.check_circle,
//         color: LightColor.midnightBlue,
//         size: 30,
//       ),
//       textStyle: TextStyle(
//           color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//       style: TimelineNodeStyle(
//         // lineType: TimelineNodeLineType.BottomHalf,
//         lineType: TimelineNodeLineType.Full,
//         lineColor: LightColor.yellowColor,
//       )),
//   HomePageTimelineObject(
//       message: 'In Process',
//       submsg: 'Your order is In Process',
//       icon: Icon(
//         Icons.check_circle,
//         color: LightColor.midnightBlue,
//         size: 30,
//       ),
//       textStyle: TextStyle(
//           color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//       style: TimelineNodeStyle(
//         lineType: TimelineNodeLineType.Full,
//         lineColor: LightColor.yellowColor,
//       )),
//   HomePageTimelineObject(
//       message: 'Out for Delivery',
//       submsg: 'Your order has been Out for Delivery',
//       icon: Icon(
//         Icons.check_circle,
//         color: LightColor.midnightBlue,
//         size: 30,
//       ),
//       textStyle: TextStyle(
//           color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//       style: TimelineNodeStyle(
//           lineType: TimelineNodeLineType.Full,
//           lineColor: LightColor.yellowColor)),
//   HomePageTimelineObject(
//       message: 'Delivered',
//       submsg: 'Your order has been Delivered successfully',
//       icon: Icon(
//         Icons.hourglass_full,
//         size: 30,
//       ),
//       style: TimelineNodeStyle(
//           lineType: TimelineNodeLineType.Full,
//           lineColor: LightColor.midnightBlue)),
// ];
//
// final List<HomePageTimelineObject> timelineObject1 = [
//   HomePageTimelineObject(
//       message: 'Order Received',
//       textStyle: TextStyle(
//           color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//       submsg: 'Your order has been Received successfully',
//       icon: Icon(
//         Icons.check_circle,
//         color: LightColor.midnightBlue,
//         size: 30,
//       ),
//       style: TimelineNodeStyle(
//         lineType: TimelineNodeLineType.BottomHalf,
//         lineColor: LightColor.yellowColor,
//       )),
//   HomePageTimelineObject(
//       message: 'In Process',
//       submsg: 'Your order is In Process',
//       icon: Icon(
//         Icons.check_circle,
//         color: LightColor.midnightBlue,
//         size: 30,
//       ),
//       textStyle: TextStyle(
//           color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//       style: TimelineNodeStyle(
//         lineType: TimelineNodeLineType.Full,
//         lineColor: LightColor.yellowColor,
//       )),
//   HomePageTimelineObject(
//       message: 'Out for Delivery',
//       submsg: 'Your order has been Out for Delivery',
//       icon: Icon(
//         Icons.hourglass_full,
//         size: 30,
//       ),
//       style: TimelineNodeStyle(
//           lineType: TimelineNodeLineType.Full,
//           lineColor: LightColor.midnightBlue)),
//   HomePageTimelineObject(
//       message: 'Delivered',
//       submsg: 'Your order has been Delivered successfully',
//       icon: Icon(
//         Icons.hourglass_full,
//         size: 30,
//       ),
//       style: TimelineNodeStyle(
//           lineType: TimelineNodeLineType.Full,
//           lineColor: LightColor.midnightBlue)),
// ];
//
// final List<HomePageTimelineObject> timelineObject2 = [
//   // if(widget.todo.ecommerceorderstatus=='SHIPPED - OUT_FOR_DELIVERY')(
//   HomePageTimelineObject(
//       message: 'Order Received',
//       submsg: 'Your order has been Received successfully',
//       icon: Icon(
//         Icons.check_circle,
//         color: LightColor.midnightBlue,
//         size: 30,
//       ),
//       textStyle: TextStyle(
//           color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//       style: TimelineNodeStyle(
//         lineType: TimelineNodeLineType.BottomHalf,
//         lineColor: LightColor.yellowColor,
//       )),
//   HomePageTimelineObject(
//       message: 'In Process',
//       submsg: 'Your order is In Process',
//       icon: Icon(
//         Icons.check_circle,
//         color: LightColor.midnightBlue,
//         size: 30,
//       ),
//       textStyle: TextStyle(
//           color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//       style: TimelineNodeStyle(
//         lineType: TimelineNodeLineType.Full,
//         lineColor: LightColor.yellowColor,
//       )),
//   HomePageTimelineObject(
//       message: 'Out for Delivery',
//       submsg: 'Your order has been Out for Delivery',
//       icon: Icon(
//         Icons.check_circle,
//         color: LightColor.midnightBlue,
//         size: 30,
//       ),
//       textStyle: TextStyle(
//           color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//       style: TimelineNodeStyle(
//           lineType: TimelineNodeLineType.Full,
//           lineColor: LightColor.yellowColor)),
//   HomePageTimelineObject(
//       message: 'Delivered',
//       submsg: 'Your order has been Delivered successfully',
//       icon: Icon(
//         Icons.check_circle,
//         color: LightColor.midnightBlue,
//         size: 30,
//       ),
//       textStyle: TextStyle(
//           color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//       style: TimelineNodeStyle(
//           lineType: TimelineNodeLineType.Full,
//           lineColor: LightColor.yellowColor)),
// ];
//
// final List<HomePageTimelineObject> timelineObject3 = [
//   // if(widget.todo.ecommerceorderstatus=='SHIPPED - OUT_FOR_DELIVERY')(
//   HomePageTimelineObject(
//       message: 'Order Received',
//       submsg: 'Your order has been Received successfully',
//       icon: Icon(
//         Icons.check_circle,
//         color: LightColor.midnightBlue,
//         size: 30,
//       ),
//       textStyle: TextStyle(
//           color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//       style: TimelineNodeStyle(
//         lineType: TimelineNodeLineType.BottomHalf,
//         lineColor: LightColor.yellowColor,
//       )),
//   HomePageTimelineObject(
//       message: 'In Process',
//       submsg: 'Your order is In Process',
//       icon: Icon(
//         Icons.hourglass_full,
//         size: 30,
//       ),
//       style: TimelineNodeStyle(
//         lineType: TimelineNodeLineType.Full,
//         lineColor: LightColor.yellowColor,
//       )),
//   HomePageTimelineObject(
//       message: 'Out for Delivery',
//       submsg: 'Your order has been Out for Delivery',
//       icon: Icon(
//         Icons.hourglass_full,
//         size: 30,
//       ),
//       style: TimelineNodeStyle(
//           lineType: TimelineNodeLineType.Full,
//           lineColor: LightColor.yellowColor)),
//   HomePageTimelineObject(
//       message: 'Delivered',
//       submsg: 'Your order has been Delivered successfully',
//       icon: Icon(
//         Icons.hourglass_full,
//         size: 30,
//       ),
//       style: TimelineNodeStyle(
//           lineType: TimelineNodeLineType.Full,
//           lineColor: LightColor.yellowColor)),
// ];
//
// shipped(title) {
//   var t=title;
//   if(t=='SHIPPED - OUT_FOR_DELIVERY') {
//     return
//       Container(
//           height: 400,
//           child: ListView.builder(
//               itemCount: timelineObject.length,
//               itemBuilder: (context, index) {
//                 TimelineNode(
//                   style: timelineObject[index].style,
//                   indicator: SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Container(
//                         color: LightColor.yellowColor,
//                       ),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(4),
//                     child: Card(
//                       child: Padding(
//                           padding: EdgeInsets.all(16),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                     mainAxisAlignment: MainAxisAlignment
//                                         .spaceBetween,
//                                     children: <Widget>[
//                                       Text(
//                                         timelineObject[index].message,
//                                         style: timelineObject[index].textStyle,
//                                       ),
//                                       timelineObject[index].icon,
//                                     ]),
//                                 Text(
//                                   timelineObject[index].submsg,
//                                   style: TextStyle(
//                                     fontSize: 10,
//                                   ),
//                                 ),
//                               ])),
//                     ),
//                   ),
//                 );
//               }));
//   }
// }
//
// Grid(context, data) {
//   return Container(
//   height: 500,
//     child:ListView.builder(
//     itemCount: data.length,
//     itemBuilder: (context, index) {
//       shipped(data[index].title);
//       if (data[index].title == 'SHIPPED - OUT_FOR_DELIVERY') {
//         return TimelineNode(
//           style: timelineObject[index].style,
//           indicator: SizedBox(
//             width: 20,
//             height: 20,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Container(
//                 color: LightColor.yellowColor,
//               ),
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(4),
//             child: Card(
//               child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text(
//                                 timelineObject[index].message,
//                                 style: timelineObject[index].textStyle,
//                               ),
//                               timelineObject[index].icon,
//                             ]),
//                         Text(
//                           timelineObject[index].submsg,
//                           style: TextStyle(
//                             fontSize: 10,
//                           ),
//                         ),
//                       ])),
//             ),
//           ),
//         );
//       } else if (data[index].title == 'IN_PROCESS') {
//         return TimelineNode(
//           style: timelineObject1[index].style,
//           indicator: SizedBox(
//             width: 20,
//             height: 20,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Container(
//                 color: LightColor.yellowColor,
//               ),
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(4),
//             child: Card(
//               child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text(
//                                 timelineObject1[index].message,
//                                 style: timelineObject1[index].textStyle,
//                               ),
//                               timelineObject1[index].icon,
//                             ]),
//                         Text(timelineObject1[index].submsg,
//                             style: TextStyle(
//                               fontSize: 10,
//                             )),
//                       ])),
//             ),
//           ),
//         );
//       } else if (data[index].title == 'DELIVERED') {
//         return TimelineNode(
//           style: timelineObject2[index].style,
//           indicator: SizedBox(
//             width: 20,
//             height: 20,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Container(
//                 color: LightColor.yellowColor,
//               ),
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(4),
//             child: Card(
//               child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text(
//                                 timelineObject2[index].message,
//                                 style: timelineObject2[index].textStyle,
//                               ),
//                               timelineObject2[index].icon,
//                             ]),
//                         Text(timelineObject2[index].submsg,
//                             style: TextStyle(
//                               fontSize: 10,
//                             )),
//                       ])),
//             ),
//           ),
//         );
//       } else {
//         return TimelineNode(
//           style: timelineObject3[index].style,
//           indicator: SizedBox(
//             width: 20,
//             height: 20,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Container(
//                 color: LightColor.yellowColor,
//               ),
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(4),
//             child: Card(
//               child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text(
//                                 timelineObject3[index].message,
//                                 style: timelineObject3[index].textStyle,
//                               ),
//                               timelineObject3[index].icon,
//                             ]),
//                         Text(timelineObject3[index].submsg,
//                             style: TextStyle(
//                               fontSize: 10,
//                             )),
//                       ])),
//             ),
//           ),
//         );
//       }
//     },
//   ));
// }
