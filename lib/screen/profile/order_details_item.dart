import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';


import 'package:robustremedy/themes/light_color.dart';


class order_details {
  final String id;
  final String order_id;
  final String item_code;
  final String itemname_en;
  final String img;
  final String quantity;
  final String gross_total;
  final String total_tax;
  final String total_discount;
  final String net_total;

  order_details({this.id,
    this.order_id,
    this.item_code,
    this.itemname_en,
    this.img,
    this.quantity,
    this.gross_total,
    this.total_tax,
    this.total_discount,
    this.net_total,
  });
//List data;
  factory order_details.fromJson(Map<String, dynamic> json) {
    return order_details(
        id: json['id'],
        order_id: json['order_id'],
        item_code: json['item_code'],
        itemname_en: json['itemname_en'],
        img: json['img'],
        quantity: json['quantity'],
        gross_total: json['gross_total'],
        total_tax: json['total_tax'],
        total_discount: json['total_discount'],
        net_total: json['net_total'],

    );
  }
}
class OrderdetailsItemsDemo extends StatefulWidget {
  final id;
  OrderdetailsItemsDemo({Key key, @required this.id}) : super(key: key);
  //List data;
  @override
  _OrderdetailsItemsDemoState createState() => _OrderdetailsItemsDemoState();
}

class _OrderdetailsItemsDemoState extends State<OrderdetailsItemsDemo> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<order_details>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<order_details> data = snapshot.data;
          return imageSlider(context, data);

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),));
      },
    );
  }

  Future<List<order_details>> _fetchJobs() async {
    final jobsListAPIUrl = 'https://onlinefamilypharmacy.com/mobileapplication/order_details_item.php';
    var data = {'itemid':widget.id};
    final response = await http.post(jobsListAPIUrl, body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new order_details.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
imageSlider(context,data) {
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
        return InkWell(

            child: Card(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            width: 100,
                            height:100,
                            child:  new Image.network(
                              'https://onlinefamilypharmacy.com/images/item/'+data[index].img,
                              fit: BoxFit.fitWidth,
                              width: 100,
                            )

                        ),
                        SizedBox(height: 10,),
                        SizedBox( width: 120, height:20,
                            child: Padding( padding: EdgeInsets.only(left: 10,),
                              child: Text(data[index].itemname_en, textAlign: TextAlign.left,
                                  // softWrap: true,
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400,color:LightColor.midnightBlue)),

                            ) ),
//Divider(),
                        SizedBox( width: 120, height:20,

                            child: Padding( padding: EdgeInsets.only(left: 15,),
                              child:Text("\QR ${data[index].net_total} x ${data[index].quantity}", textAlign: TextAlign.left,
                                  // softWrap: true,
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color:LightColor.midnightBlue)),
                            ) ),





                      ]
                  ),

                )

            )

        );
      },

      //   ),
      //   ),

//    ],

    );
}


