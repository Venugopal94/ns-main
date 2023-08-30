import 'package:flutter/material.dart';
import 'package:robustremedy/screen/home/cart.dart';
import 'package:robustremedy/screen/home/summer_items.dart';
import 'package:robustremedy/screen/profile/order_details_item.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:timelines/timelines.dart';

import '../prescription/myprescription_detail.dart';
//import 'package:timeline_node/timeline_node.dart';

class myorderdetail extends StatefulWidget {
  final todo;

  myorderdetail({Key? key, required this.todo}) : super(key: key);

  @override
  _myorderdetailState createState() => _myorderdetailState();
}

class _myorderdetailState extends State<myorderdetail> {
  @override
  Widget build(BuildContext context) {
    final List<HomePageTimelineObject> timelineObject = [
      HomePageTimelineObject(
          message: 'Order Received',
          submsg: 'Your order has been Received successfully',
          icon: Icon(
            Icons.check_circle,
            color: LightColor.midnightBlue,
            size: 30,
          ),
          textStyle: TextStyle(
              color: LightColor.midnightBlue, fontWeight: FontWeight.bold),),
      HomePageTimelineObject(
          message: 'In Process',
          submsg: 'Your order is In Process',
          icon: Icon(
            Icons.check_circle,
            color: LightColor.midnightBlue,
            size: 30,
          ),
          textStyle: TextStyle(
              color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
          ),
      HomePageTimelineObject(
          message: 'Out for Delivery',
          submsg: 'Your order has been Out for Delivery',
          icon: Icon(
            Icons.check_circle,
            color: LightColor.midnightBlue,
            size: 30,
          ),
          textStyle: TextStyle(
              color: LightColor.midnightBlue, fontWeight: FontWeight.bold),),
      HomePageTimelineObject(
          message: 'Delivered',
          submsg: 'Your order has been Delivered successfully',
          icon: Icon(
            Icons.hourglass_full,
            size: 30,
          ),
          ),
    ];

    final List<HomePageTimelineObject> timelineObject1 = [
      HomePageTimelineObject(
          message: 'Order Received',
          textStyle: TextStyle(
              color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
          submsg: 'Your order has been Received successfully',
          icon: Icon(
            Icons.check_circle,
            color: LightColor.midnightBlue,
            size: 30,
          ),),
      HomePageTimelineObject(
          message: 'In Process',
          submsg: 'Your order is In Process',
          icon: Icon(
            Icons.check_circle,
            color: LightColor.midnightBlue,
            size: 30,
          ),
          textStyle: TextStyle(
              color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
          ),
      HomePageTimelineObject(
          message: 'Out for Delivery',
          submsg: 'Your order has been Out for Delivery',
          icon: Icon(
            Icons.hourglass_full,
            size: 30,
          ),),
      HomePageTimelineObject(
          message: 'Delivered',
          submsg: 'Your order has been Delivered successfully',
          icon: Icon(
            Icons.hourglass_full,
            size: 30,
          ),),
    ];

    final List<HomePageTimelineObject> timelineObject2 = [
      // if(widget.todo.ecommerceorderstatus=='SHIPPED - OUT_FOR_DELIVERY')(
      HomePageTimelineObject(
          message: 'Order Received',
          submsg: 'Your order has been Received successfully',
          icon: Icon(
            Icons.check_circle,
            color: LightColor.midnightBlue,
            size: 30,
          ),
          textStyle: TextStyle(
              color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
          ),
      HomePageTimelineObject(
          message: 'In Process',
          submsg: 'Your order is In Process',
          icon: Icon(
            Icons.check_circle,
            color: LightColor.midnightBlue,
            size: 30,
          ),
          textStyle: TextStyle(
              color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
          ),
      HomePageTimelineObject(
          message: 'Out for Delivery',
          submsg: 'Your order has been Out for Delivery',
          icon: Icon(
            Icons.check_circle,
            color: LightColor.midnightBlue,
            size: 30,
          ),
          textStyle: TextStyle(
              color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
          ),
      HomePageTimelineObject(
          message: 'Delivered',
          submsg: 'Your order has been Delivered successfully',
          icon: Icon(
            Icons.check_circle,
            color: LightColor.midnightBlue,
            size: 30,
          ),
          textStyle: TextStyle(
              color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
          ),
    ];

    final List<HomePageTimelineObject> timelineObject3 = [
      // if(widget.todo.ecommerceorderstatus=='SHIPPED - OUT_FOR_DELIVERY')(
      HomePageTimelineObject(
          message: 'Order Received',
          submsg: 'Your order has been Received successfully',
          icon: Icon(
            Icons.check_circle,
            color: LightColor.midnightBlue,
            size: 30,
          ),
          textStyle: TextStyle(
              color: LightColor.midnightBlue, fontWeight: FontWeight.bold),
          ),
      HomePageTimelineObject(
          message: 'In Process',
          submsg: 'Your order is In Process',
          icon: Icon(
            Icons.hourglass_full,
            size: 30,
          ),
          ),
      HomePageTimelineObject(
          message: 'Out for Delivery',
          submsg: 'Your order has been Out for Delivery',
          icon: Icon(
            Icons.hourglass_full,
            size: 30,
          ),),
      HomePageTimelineObject(
          message: 'Delivered',
          submsg: 'Your order has been Delivered successfully',
          icon: Icon(
            Icons.hourglass_full,
            size: 30,
          ),),
    ];

    return Scaffold(

        // backgroundColor: LightColor.yellowColor,
        appBar: AppBar(
          title: Text('Order Details'),
          backgroundColor: LightColor.yellowColor,
          foregroundColor: LightColor.midnightBlue,
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: Container(
                  child: Column(children: <Widget>[
            Expanded(
                child: Container(
                    //padding: EdgeInsets.only(left: 15, right: 15),
                    child: ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),

                  Text(
                    "",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  if (widget.todo.ecommerceorderstatus == "RECEIVED_ORDER")
                    (Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Chip(
                          backgroundColor: Colors.red,
                          label: Text(
                            'RECEIVED ORDER',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )))
                  else if (widget.todo.ecommerceorderstatus == "IN_PROCESS")
                    (Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Chip(
                          backgroundColor: LightColor.yellowColor,
                          label: Text(
                            'IN PROCESS',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )))
                  else if (widget.todo.ecommerceorderstatus ==
                      "SHIPPED - OUT_FOR_DELIVERY")
                    (Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Chip(
                          backgroundColor: Colors.blue,
                          label: Text(
                            'SHIPPED - OUT FOR DELIVERY',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )))
                  else if (widget.todo.ecommerceorderstatus == "DELIVERED")
                    (Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Chip(
                          backgroundColor: Colors.green,
                          label: Text(
                            'DELIVERED',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )))
                  else
                    (Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        widget.todo.ecommerceorderstatus,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),

//                  Center(
//                      child:Chip(
//                        backgroundColor: LightColor.yellowColor,
//                        label: Text(
//
//                     widget.todo.ecommerceorderstatus,
//                      style: TextStyle(
//                          fontSize: 17,
//                          fontWeight: FontWeight.bold,
//                          color: LightColor.midnightBlue),
//
//
//                    ),)
//                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "\ View Order Details",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(120.0),
                      border: TableBorder.all(
                          color: Colors.black12,
                          style: BorderStyle.solid,
                          width: 2),
                      children: [
                        TableRow(children: [
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "\  Order No ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.todo.id,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "\ Order Date ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.todo.created_on,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "\ Amount ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.todo.amount,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "View Item Details",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      height: 175,
                      child: OrderdetailsItemsDemo(id: widget.todo.id),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "\ Payment Details",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(120.0),
                      border: TableBorder.all(
                          color: Colors.black12,
                          style: BorderStyle.solid,
                          width: 2),
                      children: [
                        /*TableRow(children: [
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "\  Payment Mode ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.todo.mode,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "\ Bill Amount + Shipping Amount",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.todo.net_total,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                        ]),*/
                        TableRow(children: [
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "\ Payment Service ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.todo.mode_service,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "\ Payment Date  ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.todo.created_on,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                        ]),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      constraints: BoxConstraints(
                        maxHeight: 400,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: timelineObject.length,
                        itemBuilder: (context, index) {
                          if (widget.todo.ecommerceorderstatus ==
                              'SHIPPED - OUT_FOR_DELIVERY') {
                            return buildTimeLineWidget(timelineObject).build(context, index);
                          } else if (widget.todo.ecommerceorderstatus ==
                              'IN_PROCESS') {
                            return buildTimeLineWidget(timelineObject1).build(context, index);
                          } else if (widget.todo.ecommerceorderstatus ==
                              'DELIVERED') {
                            return buildTimeLineWidget(timelineObject2).build(context, index);
                          } else {
                            return buildTimeLineWidget(timelineObject3).build(context, index);
                          }
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ]))),
          ])))
        ]));
  }

  TimelineTileBuilder buildTimeLineWidget(
      List<HomePageTimelineObject> processes) {
    return TimelineTileBuilder.connected(
      contentsAlign: ContentsAlign.basic,
      connectionDirection: ConnectionDirection.before,
      itemCount: processes.length,
      nodePositionBuilder: (_, index) {
        return 0.03;
      },
      indicatorPositionBuilder: (_, index) {
        return 0.5;
      },
      contentsBuilder: (_, index) {
        //your Container/Card Content
        return Padding(
          padding: EdgeInsets.all(4),
          child: Card(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: <Widget>[
                            Text(
                              processes[index]
                                  .message,
                              style:
                              processes[index]
                                  .textStyle,
                            ),
                            processes[index].icon,
                          ]),
                      Text(processes[index].submsg,
                          style: TextStyle(
                            fontSize: 10,
                          )),
                    ])),
          ),
        );
      },
      indicatorBuilder: (_, index) {
        return SizedBox(
          width: 20,
          height: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: LightColor.yellowColor,
            ),
          ),
        );
      },
      connectorBuilder: (_, index, ___) => SolidLineConnector(
        color: processes[index].textStyle != null ? LightColor.yellowColor : LightColor.midnightBlue,
        thickness: 2,
      ),
      lastConnectorBuilder: (_) => SolidLineConnector(
        color: processes.last.textStyle != null ? LightColor.yellowColor : LightColor.midnightBlue,
        thickness: 2,
      ),
    );
  }
}
