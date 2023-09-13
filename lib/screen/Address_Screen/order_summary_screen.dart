import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Address_Screen/address_screen.dart';
import 'package:robustremedy/screen/Address_Screen/order_generated.dart';
import 'package:robustremedy/screen/Address_Screen/payment_option.dart';
import 'package:robustremedy/screen/home/cart.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

// List<int> itemcode = List();
// List<int> quantity = List();
// List<int> price = List();
List<Shipping> shippment = [];




class PaymentScreen extends StatefulWidget {
  final addid;
  int total; // For calculation
  double? actutalTotal;
  PaymentScreen({Key? key, required this.addid, required this.total,  this.actutalTotal})
      : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? selectedRadioTile, selectedRadio;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future getShippingCharge() async {
    String url =
        'https://onlinefamilypharmacy.com/mobileapplication/shippingcharge.php';

    Map<String, dynamic> data = {
      'zoneId': int.parse(widget.addid.zone),
      'total': widget.total
    };
    var response = await http.post(Uri.parse( url), body: json.encode(data));

    List jsonDecoded = json.decode(response.body);
    setState(() {
      shippment = jsonDecoded.map((e) => Shipping.fromJson(e)).toList();
    });

    return shippment;
  }

  @override
  void initState() {
    super.initState();
    getShippingCharge();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      print(selectedRadioTile);
    });
  }

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String? user_id = prefs.getString('id');
    return user_id;
  }

  Future<int> payment(List<ProductAddToCart> product) async {
    dynamic token = await getStringValues();
    int delchrg =
        widget.total < int.parse(shippment[0].lessthan)
            ? (int.parse(shippment[0].lessthanshippingamt) +
                int.parse(shippment[0].shipping_charges))
            : ((int.parse(shippment[0].shipping_charges)));
    int newTotal =
        widget.total < int.parse(shippment[0].lessthan)
            ? (int.parse(shippment[0].lessthanshippingamt) +
                widget.total +
                int.parse(shippment[0].shipping_charges))
            : ((int.parse(shippment[0].shipping_charges) +
                widget.total));

    var mode_service;

    if ((selectedRadioTile == 1) || (selectedRadioTile == 2)) {
      if (selectedRadioTile == 1) {
        mode_service = 'Cash On Delivery';
      } else if (selectedRadioTile == 2){
        mode_service = 'Card On Delivery';
      }
      // itemcode = itemcode.toSet().toList();
      

      var data = {
        'user_id': token,
        'addressid': widget.addid.addressid,
        'title': widget.addid.title,
        'building': widget.addid.building,
        'street': widget.addid.street,
        'area': widget.addid.area,
        'country': widget.addid.country,
        'gross_total': newTotal - delchrg,
        'total': newTotal,
        'delivery_charges': delchrg,
        'mode_service': mode_service,
        'itemcode': product.map((e) => e.id).toList(),
        'quantity': product.map((e) => e.quantity).toList(),
        'price': product.map((e) => e.price).toList(),
        'multiplied_price': product.map((e) => e.price * e.quantity).toList() 
      };
      var url =
          'https://onlinefamilypharmacy.com/mobileapplication/order_payment.php';

      var response = await http.post(Uri.parse( url), body: json.encode(data));

      log(response.body);

      return int.parse(response.body);
    }

    return 0;
  }

  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    
    return ScopedModelDescendant<CartModel>(builder: (context,child,  model){
      return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Order Summary"),
        backgroundColor: LightColor.yellowColor,
        foregroundColor: LightColor.midnightBlue,
      ),
      body: shippment.isNotEmpty ? SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
          child: Column(children: <Widget>[
            Container(
              // height: 110*d,
              height: 250,
              child: Summary_Cart(),
            ),
            Container(
              height: height / 7,
              // child:  Total_payment_screen( ),
              child: Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 15.0, right: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "\ Payment Details",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "\ Delivery Charge",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        widget.total <
                                                int.parse(shippment?.first?.lessthan ?? "")
                                            ? Text(
                                                "QR ${(int.parse(shippment?.first?.lessthanshippingamt ?? "") + int.parse(shippment.first.shipping_charges))}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                "QR ${int.parse(shippment.first.shipping_charges)}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ]),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "\ Total Amount",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        widget.total <
                                                int.parse(shippment[0].lessthan)
                                            ? Text(
                                                "QR ${int.parse(shippment[0].lessthanshippingamt) + widget.total + int.parse(shippment[0].shipping_charges)}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                "QR ${int.parse(shippment[0].shipping_charges) + widget.total}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ]),
                                ])))
                  ],
                ),
              ),
            ),
            Container(
              height: height / 6,
              // child: Address_data(addid:widget.addid),
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
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  color: LightColor.yellowColor,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.addid.title,
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
                            Row(children: <Widget>[
                              Text(
                                "\Bldg No - ${widget.addid.building},",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\  Street No - ${widget.addid.street},",
                                style: TextStyle(

                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\  Area  -${widget.addid.area}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              widget.addid.country,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Container(
                height: height / 4,
                child: Column(children: <Widget>[
                  RadioListTile(
                    value: 1,
                    groupValue: selectedRadioTile,
                    title: Text(
                      "Cash On Delivery",
                      style: TextStyle(
                          fontSize: 18,
                          color: LightColor.midnightBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text("Cash / Card On Delivery"),
                    onChanged: (int? val) {
                      print("Radio Tile pressed $val");
                      setSelectedRadioTile(val ?? 0);
                    },
                    activeColor: LightColor.midnightBlue,
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: selectedRadioTile,
                    title: Text(
                      "Card On Delivery",
                      style: TextStyle(
                          fontSize: 18,
                          color: LightColor.midnightBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text("Radio 2 Subtitle"),
                    onChanged: (int? val) {
                      print("Radio Tile pressed $val");
                      setSelectedRadioTile(val ?? 0);
                    },
                    activeColor: LightColor.midnightBlue,

                    selected: false,
                  ),
                  RadioListTile(
                    value: 3,
                    groupValue: selectedRadioTile,
                    title: Text(
                      "Debit / Credit Card / Paypal",
                      style: TextStyle(
                          fontSize: 18,
                          color: LightColor.midnightBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text("Radio 2 Subtitle"),
                    onChanged: (int? val) {

                      setSelectedRadioTile(val ?? 0);
                    },
                    activeColor: LightColor.midnightBlue,

                    selected: false,
                  ),
                ])),
            SizedBox(
              height: 60.0,
            ),
          ]),
        ),
      ])) : Container(),
      floatingActionButton: Container(
          height: 50.0,
          width: 150.0,
          
          child: FloatingActionButton.extended(
            
            backgroundColor: LightColor.yellowColor,
            onPressed: () async {
              if (selectedRadioTile == 0) {
                showInSnackBar("Select Payment Method ");
              } else if ((selectedRadioTile == 1) || (selectedRadioTile == 2)) {
                int? orderId;
                 await  payment(model.cart).then((value) {
                    orderId = value;
                });
                 Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => (Order_GeneratedScreen(orderId: orderId ?? 0,))));
        ScopedModel.of<CartModel>(context).clearCart();
        ScopedModel.of<CartModel>(context).calculateTotal();
                
              } else {
                dynamic token = await getStringValues();

        
    int newTotal =
        widget.total < int.parse(shippment[0].lessthan)
            ? (int.parse(shippment[0].lessthanshippingamt) +
                widget.total +
                int.parse(shippment[0].shipping_charges))
            : ((int.parse(shippment[0].shipping_charges) +
                widget.total));

                int delchrg =
                widget.total < int.parse(shippment[0].lessthan)
                    ? (int.parse(shippment[0].lessthanshippingamt) +
                    int.parse(shippment[0].shipping_charges))
                    : ((int.parse(shippment[0].shipping_charges)));
                var data = {
                  'user_id': token,
                  'addressid': widget.addid.addressid,
                  'title': widget.addid.title,
                  'building': widget.addid.building,
                  'street': widget.addid.street,
                  'area': widget.addid.area,
                  'country': widget.addid.country,
                  'gross_total': newTotal - delchrg,
                  'total': newTotal,
                  'delivery_charges': delchrg,
                  'mode_service': "Online Payment",
                  'itemcode': model.cart.map((e) => e.id).toList(),
        'quantity': model.cart.map((e) => e.quantity).toList(),
        'price': model.cart.map((e) => e.price.round()).toList(),
        'multiplied_price': model.cart.map((e) => e.price * e.quantity).toList() 
                };
                // ScopedModel.of<CartModel>(context).addToApi(model.cart, token, widget.addid.addressid, widget.addid.title, widget.addid.building, widget.addid.street, widget.addid.area, widget.addid.country, newTotal);
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentOptionScreen(amount: newTotal, data: data)),

                );
                
      
              }
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
    });
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.midnightBlue,
    ));
  }
}

class Summary_Cart extends StatefulWidget {
  @override
  _Summary_CartState createState() => _Summary_CartState();
}

class _Summary_CartState extends State<Summary_Cart> {
  
  List<ProductAddToCart>? tempList;
  

  @override
  void initState() {
    super.initState();

   
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModel.of<CartModel>(context,rebuildOnChange: true).cart.length == 0 ?  Center(
        child: Container(
                          //  padding: EdgeInsets.only(left: 15, right: 15, top: 80),
                         child: Image.asset("assets/empty-cart.png")),
      ) : ListView.builder(
        shrinkWrap: true,
          itemCount: ScopedModel.of<CartModel>(context,
                        rebuildOnChange: true)
                    .total,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
        
        return ScopedModelDescendant<CartModel>(builder: (context,child,model){


          
          
          
         return Card(
          child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
              width: 100,
              height: 100,
              child: new Image.network(
                'https://onlinefamilypharmacy.com/images/item/' +
                    model.cart[index].img,
                fit: BoxFit.fitWidth,
                width: 100,
              )),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              width: 120,
              height: 50,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    model.cart[index].title, textAlign: TextAlign.left,
                    // softWrap: true,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: LightColor.midnightBlue),
                    overflow: TextOverflow.ellipsis, maxLines: 4,
                  ),
                ),
              )),
//Divider(),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              width: 120,
              height: 20,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Text(
                    "\QR ${model.cart[index].price} x ${model.cart[index].quantity}",
                    textAlign: TextAlign.left,
                    // softWrap: true,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: LightColor.midnightBlue)),
              )),
          //  SizedBox( width: 120, height:20,

          //  child:
          Chip(
            backgroundColor: LightColor.yellowColor,
            label: Text(
              '${model.cart[index].quantity * model.cart[index].price}',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ]),
      ));
        });
      }),
      // body: FutureBuilder<List<CartItem>>(
      //   future: _fetchItem(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       List<CartItem> data = snapshot.data;
      //       if (snapshot.data.length == 0) {
      //         return Image.asset("assets/empty-cart.png");
      //       }

      //       return imageSlider(context, data);
      //     } else if (snapshot.hasError) {
      //       return Text("${snapshot.error}");
      //     }

      //     return Center(
      //         child: CircularProgressIndicator(
      //       valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
      //     ));
      //   },
      // ),
      
    );
  }

  // Future<List<CartItem>> _fetchItem() async {
  //   dynamic token = await getStringValues();
  //   print(token);
  //   var data = {
  //     'userid': token,
  //   };
  //   var url = 'https://onlinefamilypharmacy.com/mobileapplication/cart_api.php';
  //   var response = await http.post(url, body: json.encode(data));
  //   print("I am here my jaan");
  //   print(response.body.toString());

  //   List jsonResponse = json.decode(response.body);
  //   return jsonResponse.map((item) => new CartItem.fromJson(item)).toList();
  // }

//   imageSlider(context, data) {
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: data.length,
//       itemBuilder: (context, index) {
//         int id = int.parse(data[index].itemid);
//         int qt = int.parse(data[index].quantity);
//         int pr = int.parse(data[index].finalprice);
        
//         quantity.add(qt);
//         price.add(pr);
//         itemcode.add(id);

//         return InkWell(
//             onTap: () {},
//             child: Card(
//                 child: SingleChildScrollView(
//               child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                 Container(
//                     width: 100,
//                     height: 100,
//                     child: new Image.network(
//                       'https://onlinefamilypharmacy.com/images/item/' +
//                           data[index].img,
//                       fit: BoxFit.fitWidth,
//                       width: 100,
//                     )),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(
//                     width: 120,
//                     height: 50,
//                     child: Container(
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                           left: 10,
//                         ),
//                         child: Text(
//                           data[index].title, textAlign: TextAlign.left,
//                           // softWrap: true,
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                               color: LightColor.midnightBlue),
//                           overflow: TextOverflow.ellipsis, maxLines: 4,
//                         ),
//                       ),
//                     )),
// //Divider(),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(
//                     width: 120,
//                     height: 20,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         left: 15,
//                       ),
//                       child: Text(
//                           "\QR ${data[index].price} x ${data[index].quantity}",
//                           textAlign: TextAlign.left,
//                           // softWrap: true,
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.bold,
//                               color: LightColor.midnightBlue)),
//                     )),
//                 //  SizedBox( width: 120, height:20,

//                 //  child:
//                 Chip(
//                   backgroundColor: LightColor.yellowColor,
//                   label: Text(
//                     'QR ${data[index].finalprice}',
//                     style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                 ),
//               ]),
//             )));
//       },
//     );
//   }
}


class Shipping {
  final String shipping_charges;
  final String lessthan;
  final String lessthanshippingamt;

  Shipping({
    required this.shipping_charges,
    required this.lessthan,
    required this.lessthanshippingamt,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      shipping_charges: json['shipping_charges'],
      lessthan: json['lessthan'],
      lessthanshippingamt: json['lessthanshippingamt'],
    );
  }
}