
// TODO
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:robustremedy/screen/Address_Screen/address_screen.dart';
// import 'package:robustremedy/screen/home/cart.dart';
// import 'package:robustremedy/screen/prescription/prescription_address.dart';
// import 'package:robustremedy/screen/prescription/prescription_order_detail.dart';
// import 'package:robustremedy/themes/light_color.dart';
// import 'package:timeline_node/timeline_node.dart';
//
// class TotalPrescription {
//   final String Rs;
//
//   // final String email;
//   TotalPrescription({
//     this.Rs,
//   });
// //List data;
//   factory TotalPrescription.fromJson(Map<String, dynamic> json) {
//     return TotalPrescription(
//       Rs: json['Rs'],
//     );
//   }
// }
//
// class mypredetail extends StatefulWidget {
//   final todo;
//
//   mypredetail({Key key, @required this.todo}) : super(key: key);
//
//   @override
//   _mypredetailState createState() => _mypredetailState();
// }
//
// class HomePageTimelineObject {
//   final TimelineNodeStyle style;
//   final String message;
//   final TextStyle textStyle;
//   final String submsg;
//   final Icon icon;
//
//   HomePageTimelineObject(
//       {this.style, this.message, this.textStyle, this.submsg, this.icon});
// }
//
// class _mypredetailState extends State<mypredetail> {
//   final List<HomePageTimelineObject> timelineObject = [
//     HomePageTimelineObject(
//         message: 'Awaiting Approval',
//         submsg: 'Your order is in Awaiting stage',
//         icon: Icon(
//           Icons.check_circle,
//           color: LightColor.midnightBlue,
//           size: 30,
//         ),
//         textStyle: TextStyle(
//             color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//         style: TimelineNodeStyle(
//           // lineType: TimelineNodeLineType.BottomHalf,
//           lineType: TimelineNodeLineType.Full,
//           lineColor: LightColor.yellowColor,
//         )),
//     HomePageTimelineObject(
//         message: 'Approved',
//         submsg: 'Your order is Approved',
//         icon: Icon(
//           Icons.check_circle,
//           color: LightColor.midnightBlue,
//           size: 30,
//         ),
//         textStyle: TextStyle(
//             color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//         style: TimelineNodeStyle(
//           lineType: TimelineNodeLineType.Full,
//           lineColor: LightColor.yellowColor,
//         )),
//     HomePageTimelineObject(
//         message: 'Processed',
//         submsg: 'Your order is Processed',
//         icon: Icon(
//           Icons.hourglass_full,
//           size: 30,
//         ),
//         style: TimelineNodeStyle(
//             lineType: TimelineNodeLineType.Full,
//             lineColor: LightColor.midnightBlue)),
//   ];
//
//   final List<HomePageTimelineObject> timelineObject1 = [
//     HomePageTimelineObject(
//         message: 'Awaiting Approval',
//         textStyle: TextStyle(
//             color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//         submsg: 'Your order is in Awaiting stage',
//         icon: Icon(
//           Icons.check_circle,
//           color: LightColor.midnightBlue,
//           size: 30,
//         ),
//         style: TimelineNodeStyle(
//           lineType: TimelineNodeLineType.BottomHalf,
//           lineColor: LightColor.yellowColor,
//         )),
//     HomePageTimelineObject(
//         message: 'Approved',
//         submsg: 'Your order is Approved',
//         icon: Icon(
//           Icons.hourglass_full,
//           size: 30,
//         ),
//         style: TimelineNodeStyle(
//           lineType: TimelineNodeLineType.Full,
//           lineColor: LightColor.midnightBlue,
//         )),
//     HomePageTimelineObject(
//         message: 'Processed',
//         submsg: 'Your order is Processed',
//         icon: Icon(
//           Icons.hourglass_full,
//           size: 30,
//         ),
//         style: TimelineNodeStyle(
//             lineType: TimelineNodeLineType.Full,
//             lineColor: LightColor.midnightBlue)),
//   ];
//
//   final List<HomePageTimelineObject> timelineObject2 = [
//     // if(widget.todo.ecommerceorderstatus=='SHIPPED - OUT_FOR_DELIVERY')(
//     HomePageTimelineObject(
//         message: 'Awaiting Approval',
//         submsg: 'Your order is in Awaiting stage',
//         icon: Icon(
//           Icons.check_circle,
//           color: LightColor.midnightBlue,
//           size: 30,
//         ),
//         textStyle: TextStyle(
//             color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//         style: TimelineNodeStyle(
//           lineType: TimelineNodeLineType.BottomHalf,
//           lineColor: LightColor.yellowColor,
//         )),
//     HomePageTimelineObject(
//         message: 'Approved',
//         submsg: 'Your order is Approved',
//         icon: Icon(
//           Icons.check_circle,
//           color: LightColor.midnightBlue,
//           size: 30,
//         ),
//         textStyle: TextStyle(
//             color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//         style: TimelineNodeStyle(
//           lineType: TimelineNodeLineType.Full,
//           lineColor: LightColor.yellowColor,
//         )),
//     HomePageTimelineObject(
//         message: 'Processed',
//         submsg: 'Your order is Processed',
//         icon: Icon(
//           Icons.check_circle,
//           color: LightColor.midnightBlue,
//           size: 30,
//         ),
//         textStyle: TextStyle(
//             color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
//         style: TimelineNodeStyle(
//             lineType: TimelineNodeLineType.Full,
//             lineColor: LightColor.yellowColor)),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//         // backgroundColor: LightColor.yellowColor,
//         appBar: AppBar(
//           title: Text('Prescription Details'),
//         ),
//         body: Column(children: <Widget>[
//           Expanded(
//               child: Container(
//                   child: Column(children: <Widget>[
//             Expanded(
//                 child: Container(
//                     //padding: EdgeInsets.only(left: 15, right: 15),
//                     child: ListView(scrollDirection: Axis.vertical, children: <
//                         Widget>[
//               SizedBox(
//                 height: 20,
//               ),
//               Center(
//                   child: Chip(
//                 backgroundColor: LightColor.yellowColor,
//                 label: Text(
//                   widget.todo.statustitle,
//                   style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                       color: LightColor.midnightBlue),
//                 ),
//               )),
//               SizedBox(
//                 height: 20,
//               ),
//               Divider(
//                 color: Colors.grey[200],
//                 height: 20,
//                 thickness: 10,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Text(
//                   "\ Patient Details",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.all(20),
//                 child: Table(
//                   defaultColumnWidth: FixedColumnWidth(120.0),
//                   border: TableBorder.all(
//                       color: Colors.black12,
//                       style: BorderStyle.solid,
//                       width: 2),
//                   children: [
//                     TableRow(children: [
//                       Column(children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "\  Patient Name ",
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ]),
//                       Column(children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             widget.todo.name,
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ]),
//                     TableRow(children: [
//                       Column(children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "\  Patient Contact ",
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ]),
//                       Column(children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             widget.todo.contact,
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ]),
//                     TableRow(children: [
//                       Column(children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "\  Is Insured ? ",
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ]),
//                       Column(children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             widget.todo.patient_insured,
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ]),
//                     TableRow(children: [
//                       Column(children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "\  Insurance Company ",
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ]),
//                       Column(children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             widget.todo.insurance_company,
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ]),
//                     TableRow(children: [
//                       Column(children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "\  Zone ",
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ]),
//                       Column(children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             widget.todo.zone,
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ]),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Text(
//                   "\ User Comments",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Text(
//                   widget.todo.user_comments,
//                   style: TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Text(
//                   "\ Admin Comments",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Text(
//                   widget.todo.admin_comments,
//                   style: TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Container(
//                   height: 205,
//                   child: Prescription_order_detailsDemo(id: widget.todo.id),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                   height: 300,
//                   child: ListView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: timelineObject.length,
//                     itemBuilder: (context, index) {
//                       if (widget.todo.statustitle == 'PARTIAL_APPROVAL') {
//                         return TimelineNode(
//                           style: timelineObject[index].style,
//                           indicator: SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Container(
//                                 color: LightColor.yellowColor,
//                               ),
//                             ),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(4),
//                             child: Card(
//                               child: Padding(
//                                   padding: EdgeInsets.all(16),
//                                   child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: <Widget>[
//                                               Text(
//                                                 timelineObject[index].message,
//                                                 style: timelineObject[index]
//                                                     .textStyle,
//                                               ),
//                                               timelineObject[index].icon,
//                                             ]),
//                                         Text(
//                                           timelineObject[index].submsg,
//                                           style: TextStyle(
//                                             fontSize: 10,
//                                           ),
//                                         ),
//                                       ])),
//                             ),
//                           ),
//                         );
//                       } else if (widget.todo.statustitle ==
//                           'AWAITING_APPROVAL') {
//                         return TimelineNode(
//                           style: timelineObject1[index].style,
//                           indicator: SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Container(
//                                 color: LightColor.yellowColor,
//                               ),
//                             ),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(4),
//                             child: Card(
//                               child: Padding(
//                                   padding: EdgeInsets.all(16),
//                                   child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: <Widget>[
//                                               Text(
//                                                 timelineObject1[index].message,
//                                                 style: timelineObject1[index]
//                                                     .textStyle,
//                                               ),
//                                               timelineObject1[index].icon,
//                                             ]),
//                                         Text(timelineObject1[index].submsg,
//                                             style: TextStyle(
//                                               fontSize: 10,
//                                             )),
//                                       ])),
//                             ),
//                           ),
//                         );
//                       } else {
//                         return TimelineNode(
//                           style: timelineObject2[index].style,
//                           indicator: SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Container(
//                                 color: LightColor.yellowColor,
//                               ),
//                             ),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(4),
//                             child: Card(
//                               child: Padding(
//                                   padding: EdgeInsets.all(16),
//                                   child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: <Widget>[
//                                               Text(
//                                                 timelineObject2[index].message,
//                                                 style: timelineObject2[index]
//                                                     .textStyle,
//                                               ),
//                                               timelineObject2[index].icon,
//                                             ]),
//                                         Text(timelineObject2[index].submsg,
//                                             style: TextStyle(
//                                               fontSize: 10,
//                                             )),
//                                       ])),
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                   )),
//               SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//             ])))
//           ]))),
//           Container(
//             height: 80,
//             child: Total_prescriptionscreen(prescription_id: widget.todo.id),
//           ),
//         ]),
//         floatingActionButton: widget.todo.statustitle == 'PARTIAL_APPROVAL' ||
//                 widget.todo.statustitle == 'APPROVED'
//             ? Container(
//                 height: 50.0,
//                 width: 150.0,
//                 //child: FittedBox(
//
//                 child: FloatingActionButton.extended(
//                   //  icon: Icon(Icons.add_shopping_cart),
//                   //  label: Text("Add to Cart"),
//                   backgroundColor: LightColor.yellowColor,
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => Prescription_Address_screen(
//                                 pre_id: widget.todo.id)));
//                   },
//                   // icon: Icon(Icons.save),
//                   label: Center(
//                       child: Text(
//                     "Proceed",
//                     style: TextStyle(
//                         fontSize: 18,
//                         color: LightColor.midnightBlue,
//                         fontWeight: FontWeight.bold),
//                   )),
//                 ))
//             : Container());
//   }
// }
//
// class Total_prescriptionscreen extends StatefulWidget {
//   final prescription_id;
//
//   Total_prescriptionscreen({Key key, @required this.prescription_id})
//       : super(key: key);
//   @override
//   _Total_prescriptionscreenState createState() =>
//       _Total_prescriptionscreenState();
// }
//
// class _Total_prescriptionscreenState extends State<Total_prescriptionscreen> {
//   @override
//   Widget build(BuildContext context) {
//     // final cart = Provider.of<Cart_>(context);
//     return Scaffold(
//       // appBar: AppBar(title: Text("Cart List")),
//       body: Column(children: <Widget>[
//         Expanded(
//           child: FutureBuilder<List<TotalPrescription>>(
//             future: _fetchTotal(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 List<TotalPrescription> data = snapshot.data;
//                 if (snapshot.data.length == 0) {
//                   return Container(
//                       padding: EdgeInsets.only(left: 15, right: 15, top: 80));
//                   //child: Image.asset("assets/cart.png"));
//                 }
//
//                 return totalSlider(context, data);
//               } else if (snapshot.hasError) {
//                 return Text("${snapshot.error}");
//               }
//               return Center(
//                   child: CircularProgressIndicator(
//                 valueColor:
//                     AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
//               ));
//             },
//           ),
//         ),
//       ]),
//     );
//   }
//
//   Future<List<TotalPrescription>> _fetchTotal() async {
//     print(widget.prescription_id);
//     var data = {'prescription_id': widget.prescription_id};
//     var url =
//         'https://onlinefamilypharmacy.com/mobileapplication/prescription_total.php';
//     var response = await http.post(url, body: json.encode(data));
//
//     List jsonResponse = json.decode(response.body);
//     // _finalprice_= jsonResponse["price"].map((item) => new Item.fromJson(item)).toList();
//
//     return jsonResponse
//         .map((item) => new TotalPrescription.fromJson(item))
//         .toList();
//   }
//
//   totalSlider(context, data) {
//     int total = 0;
//     return ListView.builder(
//       scrollDirection: Axis.vertical,
//       itemCount: data.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: EdgeInsets.all(15.0),
//           child: Row(
//             children: <Widget>[
//               Container(
//                 alignment: Alignment.topLeft,
//                 height: 10.0,
//                 width: 10.0,
//                 child: Icon(
//                   Icons.shopping_cart,
//                   size: 30,
//                 ),
//               ),
//               Expanded(
//                   child: Padding(
//                       padding: EdgeInsets.only(left: 25.0),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               "\ Total Amount ",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(
//                               height: 3,
//                             ),
//                             Text(
//                               "\ QR ${data[index].Rs}",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                           ]))),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
