import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:robustremedy/screen/Address_Screen/address_screen.dart';
import 'package:robustremedy/screen/profile/myorders_detail.dart';
import 'dart:io';
import 'dart:convert';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderItem {
  final String ecommerceorderstatus;
  final String delivery_mode;
  final String deliveryboy;
  final String id;
  final String billing_address_id;
  final String shipping_address;
  final String gross_total;
  final String total_tax;
  final String delivery_charges;
  final String total_discount;
  final String net_total;
  final String comments;
  final String delivery_pickup_date;
  final String delivery_pickup_time;
  final String created_on;
  final String first_name;
  final String last_name;
  final String mobile;
  final String email;
  final String mode;
  final String mode_service;
  final String paymentstatus;
  final String ecommerceorderpaymentstatustitle;
  final String amount;
  final String transaction_reference_no;
  // final String email;
  OrderItem({
    this.ecommerceorderstatus,
    this.delivery_mode,
    this.deliveryboy,
    this.id,
    this.billing_address_id,
    this.shipping_address,
    this.gross_total,
    this.total_tax,
    this.delivery_charges,
    this.total_discount,
    this.net_total,
    this.comments,
    this.delivery_pickup_date,
    this.delivery_pickup_time,
    this.created_on,
    this.first_name,
    this.last_name,
    this.mobile,
    this.email,
    this.mode,
    this.mode_service,
    this.paymentstatus,
    this.ecommerceorderpaymentstatustitle,
    this.amount,
    this.transaction_reference_no,
  });
//List data;
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      ecommerceorderstatus: json['ecommerceorderstatus'],
      delivery_mode: json['delivery_mode'],
      deliveryboy: json['deliveryboy'],
      billing_address_id: json['billing_address_id'],
      shipping_address: json['shipping_address'],
      gross_total: json['gross_total'],
      total_tax: json['total_tax'],
      delivery_charges: json['delivery_charges'],
      total_discount: json['total_discount'],
      net_total: json['net_total'],
      comments: json['comments'],
      delivery_pickup_date: json['delivery_pickup_date'],
      delivery_pickup_time: json['delivery_pickup_time'],
      created_on: json['created_on'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      mobile: json['mobile'],
      email: json['email'],
      mode: json['mode'],
      mode_service: json['mode_service'],
      paymentstatus: json['paymentstatus'],
      ecommerceorderpaymentstatustitle:
          json['ecommerceorderpaymentstatustitle'],
      amount: json['amount'],
      transaction_reference_no: json['transaction_reference_no'],
    );
  }
}

class myorder extends StatefulWidget {
  @override
  _myorderState createState() => _myorderState();
}

class _myorderState extends State<myorder> {
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id = prefs.getString('id');
    return user_id;
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart_>(context);
    return Scaffold(
      appBar: AppBar(title: Text("My Orders")),
      body: FutureBuilder<List<OrderItem>>(
        future: _fetchmyorder(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrderItem> data = snapshot.data;
            if (snapshot.data.length == 0) {
              return Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Image.asset("assets/noorderfound.png"));
            }

            return imageSlider(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
          ));
        },
      ),
    );
  }

  Future<List<OrderItem>> _fetchmyorder() async {
    dynamic token = await getStringValues();
    print(token);
    var data = {'userid': token};
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/myorders.php';
    var response = await http.post(url, body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    // _finalprice_= jsonResponse["price"].map((item) => new Item.fromJson(item)).toList();

    return jsonResponse.map((item) => new OrderItem.fromJson(item)).toList();
  }

  imageSlider(context, data) {
//int total=0;
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                print(data[index].id);

                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        transitionsBuilder:
                            (context, animation, animationTime, child) {
                          return SlideTransition(
                            position: Tween(
                                    begin: Offset(1.0, 0.0),
                                    end: Offset(0.0, 0.0))
                                .animate(animation),
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, animationTime) {
                          return myorderdetail(todo: data[index]);
                        })
                    //
                    );
                /*   Navigator.push(context,
                    new MaterialPageRoute(builder: (context) =>
                        myorderdetail(todo:data[index]))
                );

              */
              },
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Card(
                  // height: 150.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "\  Order ID ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    data[index].id,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  //Icon(icon.),
                                  Text(
                                    "\  Order Date ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      data[index].created_on,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "\  Status",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  if (data[index].ecommerceorderstatus ==
                                      "RECEIVED_ORDER")
                                    (Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Chip(
                                          backgroundColor: Colors.red,
                                          label: Text(
                                            'RECEIVED ORDER',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )))
                                  else if (data[index].ecommerceorderstatus ==
                                      "IN_PROCESS")
                                    (Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Chip(
                                          backgroundColor:
                                              LightColor.yellowColor,
                                          label: Text(
                                            'IN PROCESS',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )))
                                  else if (data[index].ecommerceorderstatus ==
                                      "SHIPPED - OUT_FOR_DELIVERY")
                                    (Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Chip(
                                          backgroundColor: Colors.blue,
                                          label: Text(
                                            'SHIPPED - OUT FOR DELIVERY',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )))
                                  else if (data[index].ecommerceorderstatus ==
                                      "DELIVERED")
                                    (Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Chip(
                                          backgroundColor: Colors.green,
                                          label: Text(
                                            'DELIVERED',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )))
                                  else
                                    (Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        data[index].ecommerceorderstatus,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ))
                                ]),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
