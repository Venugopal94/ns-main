import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Address_Screen/address_screen.dart';
import 'package:robustremedy/screen/home/cart.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
class TotalPrescription  {
  final String? Rs;


  // final String email;
  TotalPrescription({this.Rs, });
//List data;
  factory TotalPrescription.fromJson(Map<String, dynamic> json) {
    return TotalPrescription(
      Rs: json['Rs'],

    );
  }
}
class prescriptionorder {
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

  prescriptionorder({this.prescription_id,
    this.item_unit,
    this.item_code,
    this.itemname_en,
    this.img,
    this.quantity,
    this.approval_status,
    this.copayment_percent,
    this.discount,
    this.outofstock,this.rs,
  });
//List data;
  factory prescriptionorder.fromJson(Map<String, dynamic> json) {
    return prescriptionorder(
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
        rs:json['rs']
    );
  }
}
class Prescription_Summary_Screen extends StatefulWidget {
  final addid; final preid;
  Prescription_Summary_Screen({Key? key, @required this.addid, @required this.preid}) : super(key: key);
  @override
  _Prescription_Summary_ScreenState createState() => _Prescription_Summary_ScreenState();
}

class _Prescription_Summary_ScreenState extends State<Prescription_Summary_Screen> {

  int? selectedRadioTile,selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }
  @override

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(title: Text("Prescription Order Summary")),
      body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                Container(
                  child: Column(children: <Widget>[

                    Container(
                      // height: 110*d,
                      height:210,
                      child:Prescription_order_details(id:widget.preid),

                    ),
                    Container(
                      height: height / 7,
                      child:  Total_prescriptionscreen(prescription_id:widget.preid),


                    ),
                    Container(
                      height: height / 6,
                      child: Address_data(addid:widget.addid),
                    ),

                    Container(
                        height: height / 4,
                        child: Column(
                            children: <Widget>[
                              RadioListTile<int>(
                                value: 1,
                                groupValue: selectedRadioTile,
                                title: Text("Cash On Delivery",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: LightColor.midnightBlue,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text("Cash / Card On Delivery"),
                                onChanged: (val) {
                                  print("Radio Tile pressed $val");
                                  setSelectedRadioTile(val ?? 0);
                                },
                                activeColor: LightColor.midnightBlue,

                              ),
                              RadioListTile<int>(
                                value: 2,
                                groupValue: selectedRadioTile,
                                title: Text("Card On Delivery",style: TextStyle(
                                    fontSize: 18,
                                    color: LightColor.midnightBlue,
                                    fontWeight: FontWeight.bold),),
                                // subtitle: Text("Radio 2 Subtitle"),
                                onChanged: (val) {
                                  print("Radio Tile pressed $val");
                                  setSelectedRadioTile(val ?? 0);
                                },
                                activeColor: LightColor.midnightBlue,

                                selected: false,
                              ),
                              RadioListTile<int>(
                                value: 3,
                                groupValue: selectedRadioTile,
                                title: Text("Online Payment",style: TextStyle(
                                    fontSize: 18,
                                    color: LightColor.midnightBlue,
                                    fontWeight: FontWeight.bold),),
                                // subtitle: Text("Radio 2 Subtitle"),
                                onChanged: (val) {
                                  print("Radio Tile pressed $val");
                                  setSelectedRadioTile(val ?? 0);
                                },
                                activeColor: LightColor.midnightBlue,

                                selected: false,
                              ),
                            ])

                    ),

                  ]),


                ),

              ]
          )

      ),

      floatingActionButton: Container(
          height: 50.0,
          width: 150.0,
          //child: FittedBox(
          child: FloatingActionButton.extended(
            //  icon: Icon(Icons.add_shopping_cart),
            //  label: Text("Add to Cart"),
            backgroundColor: LightColor.yellowColor,
            onPressed: () {

            },
            // icon: Icon(Icons.save),
            label: Center(
                child: Text(
                  "Confirm",
                  style: TextStyle(
                      fontSize: 18,
                      color: LightColor.midnightBlue,
                      fontWeight: FontWeight.bold),
                )),
          )),
    );
  }
}
class Prescription_order_details extends StatefulWidget {
  final id;
  Prescription_order_details({Key? key, @required this.id}) : super(key: key);
  //List data;
  @override
  _Prescription_order_detailsState createState() => _Prescription_order_detailsState();
}

class _Prescription_order_detailsState extends State<Prescription_order_details> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<prescriptionorder>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<prescriptionorder> data = snapshot.data ?? [];
          return imageSlider(context, data);

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),));
      },
    );
  }

  Future<List<prescriptionorder>> _fetchJobs() async {
    final jobsListAPIUrl = 'https://onlinefamilypharmacy.com/mobileapplication/prescription_order_details.php';
    var data = {'prescriptionid':widget.id};
    final response = await http.post(Uri.parse( jobsListAPIUrl), body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new prescriptionorder.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
imageSlider(context,data) {
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
        finalprice=double.parse(data[index].rs)* double.parse(data[index].quantity);
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
                              'https://onlinefamilypharmacy.com/images/noimage.jpg',
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
                              child:Text("\QR ${data[index].rs} x ${data[index].quantity}", textAlign: TextAlign.left,
                                  // softWrap: true,
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color:LightColor.midnightBlue)),
                            ) ),

                        //  SizedBox( width: 120, height:20, child:
                        Chip(
                          backgroundColor: LightColor.yellowColor,
                          label: Text(
                            '$finalprice' ,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: LightColor.midnightBlue),
                          ),)
                        // ),



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


class Address_data extends StatefulWidget {
  // List data;
  final addid;
  Address_data({Key? key, @required this.addid}) : super(key: key);
  @override
  _Address_dataState createState() => _Address_dataState();
}

class _Address_dataState extends State<Address_data> {
  var addselect;
  var add;
  bool _isCheck = false;
  List<bool> _isChecks = [];

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String? user_id=prefs.getString('id');
    return user_id;
  }

  getselectadd(add) {
    return add;
  }

  var selectadd = false;
  @override
  void initState() {
    super.initState();

  }

//var id=_onRememberMeChanged(id);
  Future removeadd(id) async {
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/remove/remove_address.php';
    var data = {'id': id};
    var response = await http.post(Uri.parse( url), body: json.encode(data));
    var message = jsonDecode(response.body);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future addcheckbox(idd, val) async {
    print(val);
    var data = {'id': idd, 'value': val};
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/selected_address.php';
    var response = await http.post(Uri.parse( url), body: json.encode(data));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<add_data>>(
      future: _fetch_add_data(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<add_data> data = snapshot.data ?? [];
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

  Future<List<add_data>> _fetch_add_data() async {
    dynamic token = await getStringValues();
    var data = {'addid':widget.addid};

    var url = 'https://onlinefamilypharmacy.com/mobileapplication/address_api.php';
    var response = await http.post(Uri.parse( url), body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new add_data.fromJson(item)).toList();
  }

  imageSlider(context, data) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          for(int i=0;i<data.length;i++){

            _isChecks.add(false);
          }


          return Padding(
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
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  color: LightColor.yellowColor,
                                ),
                                Expanded(
                                  child: Text(
                                    data[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: InkResponse(
                                      onTap: () {
                                        removeadd(data[index].id);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                          Icons.delete,
                                          color: LightColor.midnightBlue,
                                        ),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(children: <Widget>[
                              Text(
                                "\Bldg No - ${data[index].building},",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\  Street No - ${data[index].street},",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\  Area  -${data[index].area}",
                                style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold,),   overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              data[index].country,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Total_prescriptionscreen extends StatefulWidget {
  final prescription_id;

  Total_prescriptionscreen({Key? key, @required this.prescription_id}) : super(key: key);
  @override
  _Total_prescriptionscreenState createState() => _Total_prescriptionscreenState();

}

class _Total_prescriptionscreenState extends State<Total_prescriptionscreen> {

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart_>(context);
    return Scaffold(
      // appBar: AppBar(title: Text("Cart List")),
      body:Column(
          children: <Widget>[
            Expanded(
              child:

              FutureBuilder<List<TotalPrescription>>(
                future: _fetchTotal(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<TotalPrescription> data = snapshot.data ?? [];
                    if (snapshot.data?.length == 0) {
                      return Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: Image.asset("assets/noorderfound.png"));
                    }

                    return totalSlider(context, data);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
                      ));
                },
              ),
            ),

          ]),

    );
  }
  Future<List<TotalPrescription>> _fetchTotal() async {
    print(widget.prescription_id);
    var data = {'prescription_id':widget.prescription_id };
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/prescription_total.php';
    var response = await http.post(Uri.parse( url), body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    // _finalprice_= jsonResponse["price"].map((item) => new Item.fromJson(item)).toList();

    return jsonResponse.map((item) => new TotalPrescription.fromJson(item)).toList();
  }

  totalSlider(context, data) {
    int total=0;
    return
      ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        shrinkWrap: true,
        physics:  NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {

          return
            Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 15.0,right: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "\ Payment Details",
                                  style: TextStyle(
                                    fontSize: 15, ),
                                ),SizedBox(height: 10,),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "\ Delivery Charge",
                                        style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "\ 0",
                                        style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.bold),
                                      ),]),SizedBox(height: 5,),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "\ Total Amount",
                                        style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "\ QR ${data[index].Rs}",
                                        style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.bold),
                                      ),]),
                                SizedBox(height: 10,),
                              ])))
                ],
              ),
            );

        },




      );
  }
}