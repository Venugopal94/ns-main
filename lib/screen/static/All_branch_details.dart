import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:robustremedy/screen/home/home_below_slider.dart';

import 'package:robustremedy/screen/static/All_branch.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/custom_divider_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchDetails extends StatefulWidget {
  allbranch todo;

  BranchDetails({Key key, @required this.todo}) : super(key: key);

  @override
  _BranchDetailsState createState() => _BranchDetailsState();
}

class _BranchDetailsState extends State<BranchDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool visible = false;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String emailValue = prefs.getString('email');
    return emailValue;
  }

  int itemid;
  int counter = 1;
  //final productprice;
  double finalprice;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void opengooglemaps() async {
      double lat = double.parse(widget.todo.locationlatitude);

      double long = double.parse(widget.todo.locationlongitude);
      final url =
          "https://www.google.com/maps/search/?api=1&query=${lat},${long}";
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
      print(url);
    }

    //List<int> sizeList = [7, 8, 9, 10];
    Color cyan = Color(0xff37d6ba);
    //List<Color> colorsList = [Colors.black, Colors.blue, Colors.red];

    int itemCount = 0;
    return Scaffold(
      key: _scaffoldKey,
       //backgroundColor: LightColor.yellowColor,
      appBar: AppBar(
        title: Text(widget.todo.branchecommercename),

        // backgroundColor: LightColor.midnightBlue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  //padding: EdgeInsets.only(left: 15, right: 15),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Container(
                        // padding: EdgeInsets.only(left: 15, right: 15),
                        height: 300.0,
                        width: 500.0,
                        child: Swiper(
                          autoplay: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return new Image.network(
                              'https://onlinefamilypharmacy.com/images/branch/' +
                                  widget.todo.img,
                              //fit: BoxFit.fitWidth,
                              height: 500, width: 500,
                            );
                          },
                          viewportFraction: 0.7,
                          scale: 0.1,
                        ),
                      ),
                      // SizedBox(),

                      /*  Positioned.fill(
                        child: Image.network(
                          widget.todo.url,
                        ),
                      ),*/
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          widget.todo.branchecommercename,
                          style: TextStyle(
                              fontSize: 24,
                              color: LightColor.midnightBlue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      SizedBox(height: 10),

                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          widget.todo.email,
                          style: TextStyle(
                              fontSize: 14, color: LightColor.midnightBlue),
                        ),
                      ),
                      SizedBox(height: 10),

                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          widget.todo.shortdescription,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Text(
                      //  finalprice.toString(),
                      // ),
                      Card(
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
                                        Icons.location_on,
                                        color: LightColor.midnightBlue,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Address",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0),
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
                                      "\Bldg No - ${widget.todo.buildingno},",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "\  Street No - ${widget.todo.street},",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(children: <Widget>[
                                    Text(
                                      "${widget.todo.streetname} ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      widget.todo.city,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " ${widget.todo.country},",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
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
                      SizedBox(height: 10),
                      Card(
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
                                        Icons.call,
                                        color: LightColor.midnightBlue,
                                      ),
                                      Expanded(
                                        child: Text(
                                          " Contact",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Tel.: "+ widget.todo.tel,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Whatsapp:"+ widget.todo.whatsapp,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Email: " + widget.todo.email,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.0,
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

                      SizedBox(height: 10),
                      Card(
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
                                        Icons.watch_later,
                                        color: LightColor.midnightBlue,
                                      ),
                                      Expanded(
                                        child: Text(
                                          " Opening Hours",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    widget.todo.openinghours,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),

                                ],
                              ),
                            )),
                          ],
                        ),
                      ),



                      SizedBox(height: 10),
                      Center(
                        child: InkWell(
                            onTap: () async {
                              await opengooglemaps();
                              // if (await MapLauncher.isMapAvailable(
                              //     MapType.google)) {
                              //   // ignore: deprecated_member_use
                              //   await MapLauncher.launchMap(
                              //     mapType: MapType.google,
                              //     coords: Coords(
                              //         double.parse(widget
                              //             .todo.locationlatitude),
                              //         double.parse(widget
                              //             .todo.locationlongitude)),
                              //     title: "Shanghai Tower",
                              //     description:
                              //         "Asia's tallest building",
                              //   );
                              // }
                            },
                            child: Chip(
                              backgroundColor: LightColor.midnightBlue,
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Get Direction',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )
                        ),
                      ),


                      footerview(),
                    ],
                  ),
                ),
              ),
            ]),
          ))
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.midnightBlue,
    ));
  }
}
