import 'dart:convert';
//import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Item_group_screen/related_products.dart';
import 'package:robustremedy/screen/auth/login.dart';
import 'package:robustremedy/screen/home/cart.dart';
import 'package:robustremedy/screen/home/home_below_slider.dart';
import 'package:robustremedy/screen/Item_group_screen/reviews.dart';
import 'package:robustremedy/screen/static/ProductVariantModel.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/badge.dart' as Badge;
import 'package:robustremedy/widgets/custom_divider_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

// class ListDetails extends StatefulWidget {
//   final todo;

//   ListDetails({Key key, @required this.todo}) : super(key: key);

//   @override
//   _ListDetailsState createState() => _ListDetailsState();
// }

// class _ListDetailsState extends State<ListDetails> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   GoogleTranslator translator = GoogleTranslator();
//   String selectedvalue;
//   String cart_total = '0';
//   String enitemproductgrouptitle;
//   String description_;
//   String endescription;
//   String addinformation;
//   String enaddinformation;
//   String Description_ = "Description";
//   String shortdesc;
//   String enshortdesc;
//   String addDescription_ = "Additional Description";
//   double manufacture = 14;
//   double itemproductgrouptitle = 19;
//   double shortdescription = 13;
//   double Description = 15;
//   // CarouselController buttonCarouselController = CarouselController();
//   List dropdata = List();
//   String cart = null;

//   int stockStatus;

//   String itemproductgrouptitle_;

//   getStringValuesSF() async {
//     var url2 =
//         'https://onlinefamilypharmacy.com/mobileapplication/getcart_count.php';
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var user_id = prefs.getString("id");
//     var data2 = {'userid': user_id};

//     // Starting Web API Call.
//     var response2 = await http.post(url2, body: json.encode(data2));
//     setState(() {
//       cart_total = jsonDecode(response2.body);
//       if (cart_total == null) {
//         cart_total = '0';
//       }
//     });
//   }

//   Future getallvalue() async {
//     var data = {'itemproductgroupid': widget.todo.itemproductgroupid};
//     var response = await http.post(
//         'https://onlinefamilypharmacy.com/mobileapplication/pages/dropdown_api.php',
//         body: json.encode(data));
//     var jsonbody = response.body;
//     var jsondata = json.decode(jsonbody);
//     setState(() {
//       dropdata = jsondata;
//     });
//   }

//   Future getselectedvalue() async {
//     var url =
//         'https://onlinefamilypharmacy.com/mobileapplication/pages/dropdown.php';
//     var data = {'id': selectedvalue};
//     var response = await http.post(url, body: json.encode(data));

//     var jsondataval = json.decode(response.body);

//     return jsondataval;
//   }

//   double finalapricedata;
//   bool visible = false;
//   getStringValues() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     //Return String

//     String user_id = prefs.getString('id');
//     return user_id;
//   }

//   Future addtofav() async {
//     dynamic token = await getStringValues();
//     var url = 'https://onlinefamilypharmacy.com/mobileapplication/addtofav.php';

//     if (token == null) {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => LoginScreen()));
//     } else {
//       var data = {
//         'user_id': token,
//         'id': itemid,
//         'title': widget.todo.itemname_en,
//         'desc': widget.todo.itemproductgrouptitle,
//         'price': widget.todo.maxretailprice
//       };

//       // Starting Web API Call.
//       var response = await http.post(url, body: json.encode(data));

//       // Getting Server response into variable.
//       var message = jsonDecode(response.body);
//       showInSnackBar(message);
//       // SweetAlert.show(context, title:message,confirmButtonColor:LightColor.midnightBlue, );
//     }
//   }

//   Future addtocart() async {
//     dynamic token = await getStringValues();
//     if (selectedvalue == null || selectedvalue.isEmpty) {
//       showInSnackBar('Please Select Variant');
//     }
//     if (token == null) {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => LoginScreen()));
//     } else {
//       var url =
//           'https://onlinefamilypharmacy.com/mobileapplication/addtocart.php';
//       if (selectedvalue == null) {
//         setState(() {
//           finalapricedata = finalprice;
//         });
//       } else {
//         finalapricedata = dropprice;
//       }
//       var data = {
//         'user_id': token,
//         'id': itemid,
//         'price': widget.todo.maxretailprice,
//         'finalprice': finalapricedata,
//         'quantity': counter,
//         'variant': selectedvalue
//       };

//       // Starting Web API Call.
//       var response = await http.post(url, body: json.encode(data));

//       getStringValuesSF();
//       // Getting Server response into variable.
//       var message = jsonDecode(response.body);
//       showInSnackBar(message);
//       // SweetAlert.show(context, title:message,confirmButtonColor:LightColor.midnightBlue, );
//     }
//   }

//   double dropprice;
//   int itemid;
//   int counter;
//   //final productprice;
//   double finalprice;
//   double prices;
//   void increment() {
//     if (selectedvalue == null) {
//       setState(() {
//         counter++;
//         finalprice = double.parse(widget.todo.maxretailprice) * counter;
//         finalapricedata = finalprice;
//       });
//     } else {
//       setState(() {
//         counter++;
//         dropprice = prices * counter;
//         finalapricedata = dropprice;
//       });
//     }
//   }

//   void decrement() {
//     if (selectedvalue == null) {
//       setState(() {
//         counter--;
//         finalprice = double.parse(widget.todo.maxretailprice) * counter;
//         finalapricedata = finalprice;
//       });
//     } else {
//       setState(() {
//         counter--;
//         dropprice = prices * counter;
//         finalapricedata = dropprice;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getallvalue();
//     getselectedvalue();
//     getStringValuesSF();
//     itemid = int.parse(widget.todo.itemid);
//     finalprice = double.parse(widget.todo.maxretailprice);
//     counter = 1;
//     itemproductgrouptitle_ = widget.todo.itemproductgrouptitle;
//     enitemproductgrouptitle = widget.todo.itemproductgrouptitle;
//     enaddinformation = widget.todo.additionalinformation;
//     description_ = widget.todo.description;
//     endescription = widget.todo.description;
//     addinformation = widget.todo.additionalinformation;
//     shortdesc = widget.todo.shortdescription;
//     enshortdesc = widget.todo.shortdescription;
//   }

//   void changeFontSize(value) async {
//     var val = value;
//     if (val == 2) {
//       setState(() {
//         manufacture = 18;
//         itemproductgrouptitle = 23;
//         shortdescription = 17;
//         Description = 19;
//       });
//     } else if (val == 3) {
//       setState(() {
//         manufacture = 10;
//         itemproductgrouptitle = 15;
//         shortdescription = 9;
//         Description = 11;
//       });
//     } else {
//       setState(() {
//         manufacture = 14;
//         itemproductgrouptitle = 19;
//         shortdescription = 13;
//         Description = 15;
//       });
//     }
//   }

//   String text = 'hi';
//   void translate(value) {
//     var val = value;
//     if (val == 1) {
//       translator.translate(itemproductgrouptitle_, to: "ar").then((output) {
//         setState(() {
//           itemproductgrouptitle_ = output.toString();
//         });
//       });
//       translator.translate(Description_, to: "ar").then((output) {
//         setState(() {
//           Description_ = output.toString();
//         });
//       });
//       translator.translate(addDescription_, to: "ar").then((output) {
//         setState(() {
//           addDescription_ = output.toString();
//         });
//       });
//       translator.translate(description_, to: "ar").then((output) {
//         setState(() {
//           description_ = output.toString();
//         });
//       });
//       translator.translate(addinformation, to: "ar").then((output) {
//         setState(() {
//           addinformation = output.toString();
//         });
//       });
//       translator.translate(shortdesc, to: "ar").then((output) {
//         setState(() {
//           shortdesc = output.toString();
//         });
//       });
//     } else {
//       setState(() {
//         itemproductgrouptitle_ = enitemproductgrouptitle;
//         Description_ = "Description";
//         addDescription_ = "Additional Description";
//         description_ = endescription;
//         addinformation = enaddinformation;
//         shortdesc = enshortdesc;
//       });
//     }
//   }

//   var list;

//   @override
//   Widget build(BuildContext context) {
//     //getStringValuesSF();
//     //List<int> sizeList = [7, 8, 9, 10];
//     Color cyan = Color(0xff37d6ba);
//     //List<Color> colorsList = [Colors.black, Colors.blue, Colors.red];
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     int itemCount = 0;
//     var _value;
//     return Scaffold(
//       key: _scaffoldKey,
//       // backgroundColor: LightColor.yellowColor,
//       appBar: AppBar(
//         leading: InkWell(
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => HomeScreen()));
//             },
//             child: Icon(Icons.arrow_back)),

//         title: Text(itemproductgrouptitle_.toString()),

//         actions: <Widget>[
//           PopupMenuButton<int>(
//             itemBuilder: (context) => [
//               PopupMenuItem(
//                 value: 1,
//                 child: Text("Default"),
//               ),
//               PopupMenuItem(
//                 value: 2,
//                 child: Text("Large"),
//               ),
//               PopupMenuItem(
//                 value: 3,
//                 child: Text("Small"),
//               ),
//             ],
//             onSelected: (value) {
//               setState(() {
//                 _value = value;
//                 changeFontSize(value);
//               });
//             },
//             icon: ImageIcon(
//               AssetImage("assets/font.png"),
//               // size: 50,
//               color: LightColor.midnightBlue,
//             ),
//           ),
//           // PopupMenuButton<int>(
//           //   itemBuilder: (context) => [
//           //     PopupMenuItem(
//           //       value: 1,
//           //       child: Text("Arabic"),
//           //     ),
//           //     PopupMenuItem(
//           //       value: 2,
//           //       child: Text("English"),
//           //     ),
//           //   ],
//           //   onSelected: (value) {
//           //     setState(() {
//           //       _value = value;
//           //       translate(value);
//           //     });
//           //   },
//           //   icon: ImageIcon(
//           //     AssetImage("assets/arabic.png"),
//           //     // size: 50,
//           //     color: LightColor.midnightBlue,
//           //   ),
//           // ),

//           Badge(
//               value: cart_total.toString(),
//               color: LightColor.midnightBlue,
//               child: IconButton(
//                 icon: Icon(
//                   Icons.shopping_cart,
//                   color: LightColor.midnightBlue,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                       context, MaterialPageRoute(builder: (context) => Cart()));
//                   // do something
//                 },
//               )),
//           //),
//         ],
//         // backgroundColor: LightColor.midnightBlue,
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//               child: Container(
//             child: Column(children: <Widget>[
//               Expanded(
//                 child: Container(
//                   //padding: EdgeInsets.only(left: 15, right: 15),
//                   child: ListView(
//                     scrollDirection: Axis.vertical,
//                     children: <Widget>[
//                       width < 600
//                           ? Column(children: <Widget>[
//                               Stack(
//                                 children: [
//                                   Container(
//                                       // padding: EdgeInsets.only(left: 15, right: 15),
//                                       height: 300.0,
//                                       width: width,
//                                       child: Carousel(
//                                         images: [
//                                           NetworkImage(
//                                               'https://onlinefamilypharmacy.com/images/item/' +
//                                                   widget.todo.img),
//                                           NetworkImage(
//                                             'https://onlinefamilypharmacy.com/images/item/' +
//                                                 widget.todo.img,
//                                           ),
//                                           NetworkImage(
//                                             'https://onlinefamilypharmacy.com/images/item/' +
//                                                 widget.todo.img,
//                                           ),
//                                         ],
//                                         dotSize: 6.0,
//                                         dotSpacing: 15.0,
//                                         dotColor: LightColor.midnightBlue,
//                                         indicatorBgPadding: 5.0,
//                                         // dotBgColor: LightColor.yellowColor.withOpacity(0.5),
//                                         borderRadius: true,
//                                       )),
//                                   Positioned(
//                                     top: 10,
//                                     child: Container(
//                                         // padding: EdgeInsets.only(left: 15, right: 15),
//                                         height: 300.0,
//                                         width: width,
//                                         child: Container(
//                                           child: Image.asset(
//                                               'assets/watermark.png'),
//                                         )),
//                                   ),
//                                 ],
//                               ),
//                               // SizedBox(),

//                               /*  Positioned.fill(
//                         child: Image.network(
//                           widget.todo.url,
//                         ),
//                       ),*/
//                               SizedBox(height: 10),
//                               /*  */
//                               Container(
//                                 padding: EdgeInsets.only(left: 5, right: 15),
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   itemproductgrouptitle_.toString(),
//                                   style: TextStyle(
//                                       fontSize: itemproductgrouptitle,
//                                       color: LightColor.midnightBlue,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               // SizedBox(width: 5),
//                               /**/
//                               // ]),),

//                               Padding(
//                                 padding: EdgeInsets.only(left: 15, right: 15),
//                                 child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: <Widget>[
//                                       Container(
//                                         child: Text(
//                                           "Manufacture- ${widget.todo.manufactureshortname}",
//                                           style: TextStyle(
//                                               fontSize: manufacture,
//                                               color: LightColor.midnightBlue),
//                                         ),
//                                       ),
//                                       SizedBox(width: 130),
//                                       IconButton(
//                                         icon: Icon(Icons.favorite, size: 30.0),
//                                         onPressed: () {
//                                           addtofav();
//                                         },
//                                       ),
//                                       IconButton(
//                                         icon: Icon(
//                                           Icons.share,
//                                           size: 30.0,
//                                         ),
//                                         onPressed: () {
//                                           final RenderBox box =
//                                               context.findRenderObject();
//                                           Share.share(
//                                               widget.todo.itemname_en +
//                                                   '\n\n Shop online on Qatar’s Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.' +
//                                                   '\n\n https://www.onlinefamilypharmacy.com/ecommerce/public/productdetails.php?code=' +
//                                                   widget.todo.itemid,
//                                               subject: "this is the subject",
//                                               sharePositionOrigin:
//                                                   box.localToGlobal(
//                                                           Offset.zero) &
//                                                       box.size);
//                                         },
//                                       ),
//                                     ]),
//                               ),
//                               getprice(widget.todo.minretailprice,
//                                   widget.todo.maxretailprice),
//                               SizedBox(height: 3),
//                               getPriceArabic(widget.todo.minretailprice,
//                                   widget.todo.maxretailprice),
//                               SizedBox(height: 10),
//                               Container(
//                                 padding: EdgeInsets.only(left: 15, right: 15),
//                                 child: Text(
//                                   shortdesc.toString(),
//                                   style: TextStyle(
//                                       fontSize: shortdescription,
//                                       color: Colors.grey),
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 4,
//                                 ),
//                               ),
//                               SizedBox(height: 10),

//                               Container(
//                                 height: 15,
//                                 alignment: Alignment.topRight,
//                                 child: Padding(
//                                     padding: const EdgeInsets.only(right: 25),
//                                     child: InkWell(
//                                       onTap: () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     Reviews_screen(
//                                                         itemproductid: widget
//                                                             .todo
//                                                             .itemproductgroupid)));
//                                       },
//                                       child: Text(
//                                         "View Reviews",
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             color: LightColor.midnightBlue,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     )),
//                               ),
//                               SizedBox(height: 10),
//                             ])
//                           : Row(children: <Widget>[
//                               Container(
//                                   // padding: EdgeInsets.only(left: 15, right: 15),
//                                   alignment: Alignment.topLeft,
//                                   height: 300.0,
//                                   width: width / 2,
//                                   child: Carousel(
//                                     images: [
//                                       NetworkImage(
//                                           'https://onlinefamilypharmacy.com/images/item/' +
//                                               widget.todo.img),
//                                       NetworkImage(
//                                         'https://onlinefamilypharmacy.com/images/item/' +
//                                             widget.todo.img,
//                                       ),
//                                       NetworkImage(
//                                         'https://onlinefamilypharmacy.com/images/item/' +
//                                             widget.todo.img,
//                                       ),
//                                     ],
//                                     dotSize: 6.0,
//                                     dotSpacing: 15.0,
//                                     dotColor: LightColor.midnightBlue,
//                                     indicatorBgPadding: 5.0,
//                                     dotBgColor:
//                                         LightColor.yellowColor.withOpacity(0.5),
//                                     borderRadius: true,
//                                   )),
//                               // SizedBox(),

//                               /*  Positioned.fill(
//                         child: Image.network(
//                           widget.todo.url,
//                         ),
//                       ),*/
//                               SizedBox(height: 10),
//                               /*  */

//                               Expanded(
//                                   child: Padding(
//                                       padding: EdgeInsets.only(left: 15.0),
//                                       child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: <Widget>[
//                                             Container(
//                                               padding: EdgeInsets.only(
//                                                   left: 15, right: 15),
//                                               child: Text(
//                                                 itemproductgrouptitle_
//                                                     .toString(),
//                                                 style: TextStyle(
//                                                     fontSize:
//                                                         itemproductgrouptitle,
//                                                     color:
//                                                         LightColor.midnightBlue,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             ),
//                                             // SizedBox(width: 5),
//                                             /**/
//                                             // ]),),

//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   left: 15, right: 15),
//                                               child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                   children: <Widget>[
//                                                     Container(
//                                                       child: Text(
//                                                         "\ Manufacture- ${widget.todo.manufactureshortname}",
//                                                         style: TextStyle(
//                                                             fontSize:
//                                                                 manufacture,
//                                                             color: LightColor
//                                                                 .midnightBlue),
//                                                       ),
//                                                     ),
//                                                     SizedBox(width: 100),
//                                                     IconButton(
//                                                       icon: Icon(Icons.favorite,
//                                                           size: 30.0),
//                                                       onPressed: () {
//                                                         addtofav();
//                                                       },
//                                                     ),
//                                                     IconButton(
//                                                       icon: Icon(
//                                                         Icons.share,
//                                                         size: 30.0,
//                                                       ),
//                                                       onPressed: () {
//                                                         final RenderBox box =
//                                                             context
//                                                                 .findRenderObject();
//                                                         Share.share(
//                                                             widget.todo
//                                                                     .itemname_en +
//                                                                 '\n\n Shop online on Qatar’s Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.' +
//                                                                 '\n\n https://www.onlinefamilypharmacy.com/ecommerce/public/productdetails.php?code=' +
//                                                                 widget.todo
//                                                                     .itemid,
//                                                             subject:
//                                                                 "this is the subject",
//                                                             sharePositionOrigin:
//                                                                 box.localToGlobal(
//                                                                         Offset
//                                                                             .zero) &
//                                                                     box.size);
//                                                       },
//                                                     ),
//                                                   ]),
//                                             ),
//                                             getprice(widget.todo.maxretailprice,
//                                                 widget.todo.minretailprice),
//                                             SizedBox(height: 3),
//                                             getPriceArabic(
//                                                 widget.todo.minretailprice,
//                                                 widget.todo.maxretailprice),
//                                             SizedBox(height: 10),
//                                             Container(
//                                               padding: EdgeInsets.only(
//                                                   left: 15, right: 15),
//                                               child: Text(
//                                                 shortdesc.toString(),
//                                                 style: TextStyle(
//                                                     fontSize: shortdescription,
//                                                     color: Colors.grey),
//                                                 overflow: TextOverflow.ellipsis,
//                                                 maxLines: 6,
//                                               ),
//                                             ),
//                                             SizedBox(height: 10),

//                                             Container(
//                                               height: 15,
//                                               alignment: Alignment.topRight,
//                                               child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           right: 25),
//                                                   child: InkWell(
//                                                     onTap: () {
//                                                       Navigator.push(
//                                                           context,
//                                                           MaterialPageRoute(
//                                                               builder: (context) =>
//                                                                   Reviews_screen(
//                                                                       itemproductid: widget
//                                                                           .todo
//                                                                           .itemproductgroupid)));
//                                                     },
//                                                     child: Text(
//                                                       "View Reviews",
//                                                       style: TextStyle(
//                                                           fontSize: 12,
//                                                           color: LightColor
//                                                               .midnightBlue,
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                   )),
//                                             ),
//                                             SizedBox(height: 10),
//                                           ])))
//                             ]),
//                       CustomDividerView(),
//                       Container(
//                           margin: EdgeInsets.only(left: 25, top: 10),
//                           child: Text('Available Variant',
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: LightColor.midnightBlue))),
//                       Padding(
//                           padding: EdgeInsets.only(left: 15, right: 15),
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Container(
//                                   padding: EdgeInsets.only(left: 15, right: 15),
//                                   child: DropdownButton(
//                                     value: selectedvalue,
//                                     hint: Text(widget.todo.itempack),
//                                     items: dropdata.map(
//                                       (list) {
//                                         return DropdownMenuItem(
//                                             child: SizedBox(
//                                               width: 150,
//                                               child: Text(list['itempack']),
//                                             ),
//                                             value: list['id']);
//                                       },
//                                     ).toList(),
//                                     onChanged: (value) {
//                                       setState(() {
//                                         selectedvalue = value;
//                                         getselectedvalue();
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(width: 3),
//                                 selectedvalue != null
//                                     ? Container(
//                                         height: 50,
//                                         width: 150,
//                                         child: FutureBuilder(
//                                             future: getselectedvalue(),
//                                             builder: (context, snapshot) {
//                                               if (snapshot.hasData) {
//                                                 if (snapshot.data.length == 0) {
//                                                   return Text(
//                                                       "No data on this itempack");
//                                                 }
//                                                 return ListView.builder(
//                                                     itemCount:
//                                                         snapshot.data.length,
//                                                     itemBuilder:
//                                                         (context, index) {
//                                                       var list =
//                                                           snapshot.data[index];
//                                                       itemid =
//                                                           int.parse(list['id']);
//                                                       dropprice = double.parse(
//                                                           list['rs']);
//                                                       prices = dropprice;

//                                                       return ListTile(
//                                                         title: Text(
//                                                           "\QR ${list['rs'].toString()}",
//                                                           style: TextStyle(
//                                                               fontSize: 18,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                         ),
//                                                       );
//                                                     });
//                                               }
//                                               return Text("");
//                                             }))
//                                     : Text(""),
//                               ])),
//                       SizedBox(height: 10),
//                       SizedBox(height: 10),
//                       Padding(
//                         padding: EdgeInsets.only(left: 15, right: 15),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             GestureDetector(
//                               child: Container(
//                                 padding: const EdgeInsets.all(5.0),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.black,
//                                 ),
//                                 child: Icon(
//                                   Icons.remove,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               onTap: () {
//                                 decrement();
//                               },
//                             ),
//                             SizedBox(width: 10),
//                             Text(
//                               '$counter',
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(width: 10),
//                             GestureDetector(
//                               child: Container(
//                                 padding: const EdgeInsets.all(5.0),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.black,
//                                 ),
//                                 child: Icon(
//                                   Icons.add,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               onTap: () {
//                                 increment();
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       CustomDividerView(),
//                       SizedBox(height: 10),
//                       selectedvalue == null
//                           ? Container(
//                               padding: EdgeInsets.only(top: 10.0, left: 15.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(
//                                     "\ Item Code- ${widget.todo.itemid}",
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: LightColor.midnightBlue),
//                                   ),

//                                   SizedBox(
//                                     height: 1.0,
//                                   ),
//                                   //finalprice=data[index].price,
//                                   Text(
//                                     "\ Item Name- ${widget.todo.itemname_en}",
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: LightColor.midnightBlue),
//                                   ),
//                                   SizedBox(height: 1),
//                                   Text(
//                                     "\ Type Of Packing- ${widget.todo.itempack}",
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: LightColor.midnightBlue),
//                                   ),

//                                   Text(
//                                     "\ Quantity Per Packing - ",
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: LightColor.midnightBlue),
//                                   ),
//                                   // SizedBox(height: 5),
//                                   Text(
//                                     widget.todo.stock == null ||
//                                             widget.todo.stock == '0'
//                                         ? 'Out Of Stock'
//                                         : widget.todo.stock + ' In Stock',
//                                     style: TextStyle(
//                                         fontSize: 17,
//                                         color: Colors.green,
//                                         fontWeight: FontWeight.bold),
//                                   ),

//                                   SizedBox(height: 1),
//                                 ],
//                               ),
//                             )
//                           : Container(
//                               height: 120,
//                               width: 150,
//                               padding: EdgeInsets.only(top: 10.0, left: 15.0),
//                               child: FutureBuilder(
//                                   future: getselectedvalue(),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.hasData) {
//                                       if (snapshot.data.length == 0) {
//                                         return Text("No data on this itempack");
//                                       }
//                                       return ListView.builder(
//                                           // shrinkWrap: true,
//                                           itemCount: snapshot.data.length,
//                                           itemBuilder: (context, index) {
//                                             list = snapshot.data[index];

//                                             return Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: <Widget>[
//                                                 Text(
//                                                   "\ Item Code- ${list['id'].toString()}",
//                                                   style: TextStyle(
//                                                       fontSize: 14,
//                                                       color: LightColor
//                                                           .midnightBlue),
//                                                 ),

//                                                 SizedBox(
//                                                   height: 1.0,
//                                                 ),
//                                                 //finalprice=data[index].price,
//                                                 Text(
//                                                   "\ Item Name- ${list['itemname_en']}",
//                                                   style: TextStyle(
//                                                       fontSize: 14,
//                                                       color: LightColor
//                                                           .midnightBlue),
//                                                 ),
//                                                 SizedBox(height: 1),
//                                                 Text(
//                                                   "\ Type Of Packing- ${list['itempack']}",
//                                                   style: TextStyle(
//                                                       fontSize: 14,
//                                                       color: LightColor
//                                                           .midnightBlue),
//                                                 ),

//                                                 Text(
//                                                   "\ Quantity Per Packing - ",
//                                                   style: TextStyle(
//                                                       fontSize: 14,
//                                                       color: LightColor
//                                                           .midnightBlue),
//                                                 ),
//                                                 // SizedBox(height: 5),
//                                                 Text(
//                                                   list['stock'] == null ||
//                                                           list['stock'] == '0'
//                                                       ? 'Out Of Stock'
//                                                       : list['stock'] +
//                                                           ' In Stock',
//                                                   style: TextStyle(
//                                                       fontSize: 17,
//                                                       color: Colors.green,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ],
//                                             );
//                                           });
//                                     }
//                                     return Text("");
//                                   })),
//                       // Container(
//                       //   alignment: Alignment.topRight,
//                       //   child: Padding(
//                       //     padding: const EdgeInsets.only(right: 8.0),
//                       //     child: Text(
//                       //       widget.todo.stock == null ||
//                       //               widget.todo.stock == '0'
//                       //           ? 'Out Of Stock'
//                       //           : widget.todo.stock + ' In Stock',
//                       //       style: TextStyle(
//                       //           fontSize: 17,
//                       //           color: Colors.green,
//                       //           fontWeight: FontWeight.bold),
//                       //     ),
//                       //   ),
//                       // ),

//                       SizedBox(height: 10),
//                       Container(
//                         padding: EdgeInsets.only(left: 15, right: 15),
//                         child: Text(
//                           Description_.toString(),
//                           style: TextStyle(
//                               fontSize: Description,
//                               color: LightColor.midnightBlue,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Container(
//                         padding: EdgeInsets.only(left: 15, right: 15),
//                         child: Text(
//                           description_.toString(),
//                           style: TextStyle(
//                               fontSize: shortdescription, color: Colors.grey),
//                           //overflow: TextOverflow.ellipsis, maxLines: 2,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Container(
//                         padding: EdgeInsets.only(left: 15, right: 15),
//                         child: Text(
//                           addDescription_.toString(),
//                           style: TextStyle(
//                               fontSize: Description,
//                               color: LightColor.midnightBlue,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Container(
//                         padding: EdgeInsets.only(left: 15, right: 15),
//                         child: Text(
//                           addinformation.toString(),
//                           style: TextStyle(
//                               fontSize: shortdescription, color: Colors.grey),
//                           //overflow: TextOverflow.ellipsis, maxLines: 2,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Container(
//                         padding: EdgeInsets.only(left: 15, right: 15),
//                         child: Text(
//                           'Related Products',
//                           style: TextStyle(
//                               fontSize: Description,
//                               color: LightColor.midnightBlue,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Container(
//                         height: 180,
//                         child: Related_products(
//                             itemid: widget.todo.itemgroupid,
//                             itemc: widget.todo.itemproductgroupid),
//                         //Related_products(),
//                       ),
//                       footerview(),
//                     ],
//                   ),
//                 ),
//               ),
//             ]),
//           )),
//         ],
//       ),

//       floatingActionButton: FloatingActionButton.extended(
//         icon: Icon(
//           Icons.add_shopping_cart,
//           color: LightColor.midnightBlue,
//         ),
//         label: widget.todo.itemclassid == '4'
//             ? Text(
//                 'Prescription Required',
//                 style: TextStyle(
//                     fontSize: 13.0,
//                     fontWeight: FontWeight.bold,
//                     color: LightColor.midnightBlue),
//               )
//             : Text(
//                 "Add to Cart",
//                 style: TextStyle(
//                     fontSize: 13.0,
//                     fontWeight: FontWeight.bold,
//                     color: LightColor.midnightBlue),
//               ),
//         backgroundColor: LightColor.yellowColor,
//         onPressed: () {
//           if (widget.todo.stock == null || widget.todo.stock == '0') {
//             showInSnackBar('Out of Stock');
//           } else if (widget.todo.itemclassid == '4') {
//             showInSnackBar('Prescription Required');
//           } else {
//             addtocart();
//           }

//           if ((list['stock'] == '0' ||
//               list['stock'] == 0 ||
//               list['stock'] == null)) {
//             showInSnackBar('Out of Stock');
//           } else if (widget.todo.itemclassid == '4') {
//             showInSnackBar('Prescription Required');
//           } else {
//             addtocart();
//           }
//         },
//       ),
//     );
//   }

//   void showInSnackBar(String value) {
//     _scaffoldKey.currentState.showSnackBar(new SnackBar(
//       content: new Text(value),
//       backgroundColor: LightColor.midnightBlue,
//     ));
//   }
// }

// String replaceFarsiNumber(String input) {
//   const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
//   const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

//   for (int i = 0; i < english.length; i++) {
//     input = input.replaceAll(english[i], farsi[i]);
//   }

//   return input;
// }

// getPriceArabic(max, min) {

//   if (max == min) {
//     return Row(children: <Widget>[
//       Container(
//         padding: EdgeInsets.only(left: 15, right: 15),
//         child: Text(
//           "\QR ${replaceFarsiNumber(max)}",
//           style: TextStyle(
//               fontSize: 17, fontWeight: FontWeight.bold, color: Colors.amber),
//         ),
//       ),
//     ]);
//   } else {
//     return Row(children: <Widget>[
//       Container(
//         padding: EdgeInsets.only(left: 15),
//         child: Text(
//           "\QR ${replaceFarsiNumber(max)}",
//           style: TextStyle(
//               fontSize: 17, fontWeight: FontWeight.bold, color: Colors.amber),
//         ),
//       ),
//       Text(" - "),
//       Text(
//         "\QR ${replaceFarsiNumber(min)}",
//         style: TextStyle(
//             fontSize: 17, fontWeight: FontWeight.bold, color: Colors.amber),
//       ),
//     ]);
//   }
// }

// getprice(max, min) {
//   if (max == min) {
//     return Row(children: <Widget>[
//       Container(
//         padding: EdgeInsets.only(left: 15, right: 15),
//         child: Text(
//           "\QR ${max}",
//           style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//         ),
//       ),
//     ]);
//   } else {
//     return Row(children: <Widget>[
//       Container(
//         padding: EdgeInsets.only(left: 15),
//         child: Text("\QR ${max}",
//             style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
//       ),
//       Text(" - "),
//       Text("\QR ${min}",
//           style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
//     ]);
//   }
// }

class ListDetails extends StatefulWidget {
  final todo;

  ListDetails({Key? key, @required this.todo}) : super(key: key);

  @override
  State<ListDetails> createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails> {
  

  // Global Variables

  String cartCount = '0';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isSelectedVariant = false;
  List<VariantProduct> productVariants = [];
  int _selectedVariant = 0;
  int quantityOfVariant = 1;

  // Get User Id;

  Future<String> getUserId() async {
    SharedPreferences pf = await SharedPreferences.getInstance();

    return pf.getString('id') ?? "";
  }

  // Get Cart count

  Future<String> getCartCount() async {
    String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/getcart_count.php';

    String userId = await getUserId();
    Map<String, String> body = {'userid': userId};

    var response2 =
        await http.post(Uri.parse(baseUrl), body: json.encode(body));

    setState(() {
      cartCount = jsonDecode(response2.body).toString();
    });

    return cartCount == null ? '0' : cartCount;
  }

  // add to Favourites
  Future<String> addtoFavourite() async {
    String userId = await getUserId();
    String baseUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/addtofav.php';

    if (userId == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      Map<String, dynamic> data = {
        'user_id': userId,
        'id': int.parse(widget.todo.itemid),
        'title': widget.todo.itemname_en,
        'desc': widget.todo.itemproductgrouptitle,
        'price': widget.todo.maxretailprice
      };

      var response =
          await http.post(Uri.parse(baseUrl), body: json.encode(data));

      if (response.statusCode == 200) {
        String message = jsonDecode(response.body);
        return message;
      } else {
        return "Network Error";
      }
    }
    return "Something Went Wrong";
  }

  // snackBar

  void showInSnackBar(String value) {
    // ignore: deprecated_member_use
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.midnightBlue,
    ));
  }

  // Arabic Numbers and Normal pricing

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  getPriceArabic(max, min) {
    if (max == min) {
      return Row(children: <Widget>[
        Container(
          child: Text(
            "\QR ${replaceFarsiNumber(max)}",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
          ),
        ),
      ]);
    } else {
      return Row(children: <Widget>[
        Container(
          child: Text(
            "\QR ${replaceFarsiNumber(min)}",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
          ),
        ),
        Text(" - "),
        Text(
          "\QR ${replaceFarsiNumber(max)}",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
        ),
      ]);
    }
  }

  getprice(max, min) {
    if (max == min) {
      return Row(children: <Widget>[
        Container(
          child: Text(
            "\QR $max",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: LightColor.midnightBlue),
          ),
        ),
      ]);
    } else {
      return Row(children: <Widget>[
        Container(
          child: Text("\QR $min",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: LightColor.midnightBlue)),
        ),
        Text(" - "),
        Text("\QR $max",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: LightColor.midnightBlue)),
      ]);
    }
  }

// get All Variants of  the product

  Future<List<VariantProduct>> getProductVariant() async {
    Map<String, String> data = {
      'itemproductgroupid': widget.todo.itemproductgroupid
    };
    var response = await http.post(
        Uri.parse( 'https://onlinefamilypharmacy.com/mobileapplication/pages/dropdown_api.php'),
        body: json.encode(data));

    List responseData = json.decode(response.body);
    setState(() {
      productVariants =
          responseData.map((e) => new VariantProduct.fromJson(e)).toList();
    });

    print(responseData);
   

    return productVariants;
  }

  // add To Cart

  Future addToCart() async {
          String userId = await getUserId();
    // if (selectedvalue == null || selectedvalue.isEmpty) {
    //   showInSnackBar('Please Select Variant');
    // }
    if (userId == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      var url =
          'https://onlinefamilypharmacy.com/mobileapplication/addtocart.php';
      
      var data = {
        'user_id': userId,
        'id': productVariants[_selectedVariant].itemid,
        'price': widget.todo.maxretailprice,
        'finalprice': productVariants[_selectedVariant].rs,
        'quantity': quantityOfVariant,
        'variant': productVariants[_selectedVariant].itempack
      };

      
      var response = await http.post(Uri.parse( url), body: json.encode(data));

      // getCartCount();
      
      var message = jsonDecode(response.body);
      // showInSnackBar(message);
  }}


  @override
  void initState() {
    super.initState();
    getCartCount();
    getProductVariant();
  }

  @override
  Widget build(BuildContext context) {
    List<Image> data = [
      Image.network(
        'https://onlinefamilypharmacy.com/images/item/' +
            widget.todo.img,fit: BoxFit.contain, ),
      Image.network(
        'https://onlinefamilypharmacy.com/images/item/' +
            widget.todo.img,fit: BoxFit.contain,
      ),
      Image.network(
        'https://onlinefamilypharmacy.com/images/item/' +
            widget.todo.img,fit: BoxFit.contain,
      ),
    ];
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.todo.itemproductgrouptitle),
          backgroundColor: LightColor.yellowColor,
          foregroundColor: LightColor.midnightBlue,
          actions: [
            Badge.Badge(
                // value: cartCount,
                value: ScopedModel.of<CartModel>(context,
                                    rebuildOnChange: true)
                                .cart.length
                                .toString(),
                color: LightColor.midnightBlue,
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: LightColor.midnightBlue,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cart()));
                  },
                )),
          ],
        ),
        body: productVariants.isEmpty ? LinearProgressIndicator(
          color: Colors.amber
        ) : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.white,
                    height: 280,
                    child: Stack(
                      children: [
                      Swiper(
                      autoplay: true,
                      itemCount: data.length,
                      indicatorLayout: PageIndicatorLayout.NONE,
                      itemBuilder: (BuildContext context, int index) {
                        return data[index];
                      },
                      viewportFraction: 0.4,
                      scale: 0.5
                    ),
                        // Carousel(
                        //   images: ,
                        //   dotSize: 6.0,
                        //   dotSpacing: 15.0,
                        //   dotColor: LightColor.midnightBlue,
                        //   indicatorBgPadding: 5.0,
                        //   dotBgColor: Colors.transparent,
                        //   borderRadius: true,
                        //   defaultImage: Image.asset('assets/noimage.jpeg'),
                        // ),
                        Positioned(
                            right: 10,
                            child: IconButton(
                                onPressed: () {
                                  Share.share(
                                    widget.todo.itemname_en +
                                        '\n\nShop online on Qatar’s Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.' +
                                        '\n\n https://www.onlinefamilypharmacy.com/productdetails.php?code=' +
                                        widget.todo.itemid,
                                    subject: "this is the subject",
                                  );
                                },
                                icon: Icon(
                                  Icons.ios_share_outlined,
                                  color:
                                      LightColor.midnightBlue.withOpacity(0.8),
                                ))),
                        Positioned(
                            right: 10,
                            top: 40,
                            child: IconButton(
                                onPressed: () async {
                                  String result = await addtoFavourite();
                                  showInSnackBar(result);
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.redAccent,
                                )))
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 40,
                    child: Container(
                        // padding:
                        //     EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        height: 250.0,
                        child: Image.asset('assets/watermark.png')),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.todo.itemproductgrouptitle.toString().trim(),
                        style: TextStyle(
                            fontSize: 18,
                            color: LightColor.midnightBlue,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left),

                    SizedBox(
                      height: 4,
                    ),
                    getprice(
                        double.parse(widget.todo.maxretailprice).toStringAsFixed(2), double.parse(widget.todo.minretailprice).toStringAsFixed(2)),
                    SizedBox(
                      height: 2,
                    ),
                    getPriceArabic(
                      widget.todo.maxretailprice,
                      widget.todo.minretailprice,
                    ),

                    // Text(widget.todo.shortdescription),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Reviews_screen(
                                        itemproductid:
                                            widget.todo.itemproductgroupid)));
                          },
                          icon: Icon(
                            Icons.reviews_outlined,
                            color: LightColor.midnightBlue.withOpacity(0.6),
                          ),
                          label: Text(
                            'View Reviews',
                            style: TextStyle(color: LightColor.midnightBlue),
                          )),
                    ),

                    CustomDividerView(),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    
                    productVariants[_selectedVariant].itempack == '' || productVariants[_selectedVariant].itempack == null  || productVariants[_selectedVariant].itempack!.isEmpty
                        ? SizedBox()
                        :    Text('Available Variants',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: LightColor.midnightBlue)),
                        _selectedVariant != null
                            ? Text(
                              
                                'QR ${double.parse(productVariants[_selectedVariant]?.rs ?? "").toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: LightColor.midnightBlue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            : SizedBox(),
                      ],
                    ),

                    productVariants[_selectedVariant].itempack == '' || productVariants[_selectedVariant].itempack == null  || productVariants[_selectedVariant].itempack!.isEmpty
                        ? SizedBox()
                        : _buildChoiceChips(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(onPressed: (){
                          setState(() {

                           quantityOfVariant ==1 ? showInSnackBar('Minimum 1 item is needed') :quantityOfVariant --;
                          }); 
                        }, icon: Icon(Icons.remove_circle_outline,color: Colors.black,size: 30,)),
                        Container(
                          
                          
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white),
                          child: Text(
                            quantityOfVariant.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        IconButton(onPressed: (){
                          setState(() {
                            quantityOfVariant ++;
                          }); 
                        }, icon: Icon(Icons.add_circle_outline,color: Colors.black,size: 30,)),
                        
                      ],
                    ),

                    _selectedVariant != null
                        ? Text(
                            'Item Code - ${productVariants[_selectedVariant].id}',
                            style: TextStyle(color: LightColor.midnightBlue),
                          )
                        : SizedBox(),

                    _selectedVariant != null
                        ? Text(
                            'Type of Packing - ${productVariants[_selectedVariant].itempack}',
                            style: TextStyle(color: LightColor.midnightBlue),
                          )
                        : SizedBox(),

                    //  _selectedVariant != null ?  Text('Type of Packing - ${productVariants[_selectedVariant].}') : SizedBox(),
                    Text(
                      'Manufacture - ${widget.todo.manufactureshortname}',
                      style: TextStyle(
                        fontSize: 14,
                        color: LightColor.midnightBlue,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    _selectedVariant != null
                        ? productVariants[_selectedVariant].stock == '0' ||
                                productVariants[_selectedVariant].stock == null
                            ? Text(
                                'Stock Status - Out Of Stock',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                'Stock Status - ${productVariants[_selectedVariant].stock}',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              )
                        : SizedBox(),

                                          SizedBox(height: 10),
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 15,
                            color: LightColor.midnightBlue,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.todo.description,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey),
                        //overflow: TextOverflow.ellipsis, maxLines: 2,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Additional Description',
                        style: TextStyle(
                            fontSize: 15,
                            color: LightColor.midnightBlue,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Container(
                        // padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          widget.todo.additionalinformation,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey),
                          
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Related Products',
                        style: TextStyle(
                            fontSize: 15,
                            color: LightColor.midnightBlue,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 180,
                        child: Related_products(
                            itemid: widget.todo.itemgroupid,
                            itemc: widget.todo.itemproductgroupid),
                        //Related_products(),
                      ),
                      footerview(),
                  ],
                ),
              ),
            ],
          ),
        ),
              floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.add_shopping_cart,
          color: LightColor.midnightBlue,
        ),
        label: widget.todo.itemclassid == '4'
            ? Text(
                'Prescription Required',
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: LightColor.midnightBlue),
              )
            : Text(
                "Add to Cart",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: LightColor.midnightBlue),
              ),
        backgroundColor: LightColor.yellowColor,
        onPressed: () {
          if (productVariants[_selectedVariant].stock == null || productVariants[_selectedVariant].stock  == '0') {
            showInSnackBar('Out of Stock');
          } else if (widget.todo.itemclassid == '4') {
            showInSnackBar('Prescription Required');
          } else if(quantityOfVariant > int.parse(productVariants[_selectedVariant]?.stock ?? "")){
            showInSnackBar('You cannot add quantity greater than stock');
          } 
          
          else {
             ProductAddToCart _product = ProductAddToCart(
                finalprice: double.parse(productVariants[_selectedVariant]?.rs ?? ""),
                id: productVariants[_selectedVariant]?.id ?? "",
                img: widget.todo.img,
                title: productVariants[_selectedVariant]?.itemnameEn ?? "",
                quantity: quantityOfVariant,
                stockStatus: int.parse(productVariants[_selectedVariant]?.stock ?? ""),
                price: double.parse(widget.todo.maxretailprice),
              );

              ScopedModel.of<CartModel>(context).addProduct(_product);
              showInSnackBar('Added Successfully');
            // addToCart();
          }

         
        },
      ),
    
  
        );
      
  }

  Widget _buildChoiceChips() {
    return Container(
      // height: MediaQuery.of(context).size.height/4,
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: productVariants.length,
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            label:  index != _selectedVariant ? Text(productVariants[index]?.itempack ?? "",style: TextStyle(color: Colors.black),):Text(productVariants[index]?.itempack ?? "",style: TextStyle(color: Colors.white),),
            selected: _selectedVariant == index,
            selectedColor: Colors.black,
            onSelected: (bool selected) {
              setState(() {
                _selectedVariant = selected ? index : 0;
                quantityOfVariant = 1;
              });
            },
            backgroundColor: index != _selectedVariant ? Colors.grey[200] :LightColor.midnightBlue,
            labelStyle:   TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }
}
