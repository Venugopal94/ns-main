import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';

import 'package:robustremedy/themes/light_color.dart';

class prescriptionorder_details {
  final String? prescription_id;
  final String? item_unit;
  final String? item_code;
  final String? itemname_en;
  final String? img;
  final String? quantity;
  final String? approval_status;
  final String? copayment_percent;
  final String? discount;
  final String? outofstock;
  final String? rs;

  prescriptionorder_details({
    this.prescription_id,
    this.item_unit,
    this.item_code,
    this.itemname_en,
    this.img,
    this.quantity,
    this.approval_status,
    this.copayment_percent,
    this.discount,
    this.outofstock,
    this.rs,
  });
//List data;
  factory prescriptionorder_details.fromJson(Map<String, dynamic> json) {
    return prescriptionorder_details(
        prescription_id: json['prescription_id'],
        item_unit: json['item_unit'],
        item_code: json['item_code'],
        itemname_en: json['itemname_en'],
        img: json['img'],
        quantity: json['quantity'],
        approval_status: json['approval_status'],
        copayment_percent: json['copayment_percent'],
        discount: json['discount'],
        outofstock: json['outofstock'],
        rs: json['rs']);
  }
}

class Prescription_order_detailsDemo extends StatefulWidget {
  final id;
  Prescription_order_detailsDemo({Key? key, @required this.id})
      : super(key: key);
  //List data;
  @override
  _Prescription_order_detailsDemoState createState() =>
      _Prescription_order_detailsDemoState();
}

class _Prescription_order_detailsDemoState
    extends State<Prescription_order_detailsDemo> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<prescriptionorder_details>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<prescriptionorder_details> data = snapshot.data ?? [];
          return imageSlider(context, data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
        ));
      },
    );
  }

  Future<List<prescriptionorder_details>> _fetchJobs() async {
    final jobsListAPIUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/prescription_order_details.php';
    var data = {'prescriptionid': widget.id};
    final response = await http.post(Uri.parse( jobsListAPIUrl), body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((job) => new prescriptionorder_details.fromJson(job))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

imageSlider(context, data) {
  double finalprice;
  return
      /*new ListView(

    children: <Widget>[
      Container(
       height: 160,
        //width:100,*/

      ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: data.length,
    itemBuilder: (context, index) {
      finalprice =
          double.parse(data[index].rs) * double.parse(data[index].quantity);
      return InkWell(
          child: Card(
              child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
              width: 100,
              height: 100,
//                            child:  new Image.network(
//                              'https://onlinefamilypharmacy.com/images/item/'+data[index].img,
//                              fit: BoxFit.fitWidth,
//                              width: 100,
//                            )

              child: new Image.network(
                'https://onlinefamilypharmacy.com/images/noimage.jpg',
                fit: BoxFit.fitWidth,
                width: 100,
              )),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              width: 120,
              height: 20,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: Text(data[index].itemname_en,
                    textAlign: TextAlign.left,
                    // softWrap: true,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: LightColor.midnightBlue)),
              )),
//Divider(),
          SizedBox(
              width: 120,
              height: 20,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Text("\QR ${data[index].rs} x ${data[index].quantity}",
                    textAlign: TextAlign.left,
                    // softWrap: true,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: LightColor.midnightBlue)),
              )),

          //  SizedBox( width: 120, height:20, child:
          Chip(
            backgroundColor: LightColor.yellowColor,
            label: Text(
              '$finalprice',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: LightColor.midnightBlue),
            ),
          )
          // ),
        ]),
      )));
    },

    //   ),
    //   ),

//    ],
  );
}
