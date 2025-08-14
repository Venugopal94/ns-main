import 'dart:convert';
import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:robustremedy/screen/profile/family_miles_history.dart';
import 'package:robustremedy/screen/profile/models/lucky_draw.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../widgets/barcode/barcode_widget.dart';
import '../home_screen.dart';
import 'models/family_points.dart';
import 'package:intl/intl.dart';

class FamilyMilesScreen extends StatefulWidget {

  @override
  _FamilyMilesScreenState createState() => _FamilyMilesScreenState();
}

class _FamilyMilesScreenState extends State<FamilyMilesScreen> {
  List<LuckyDraw>? list;

  @override
  void initState() {
    super.initState();
  }

  Future<List<FamilyPoints>> _fetchFamilyPoints() async {
    String token = await getStringValues();
    var data = {'user_id': token};

    var url =
        'https://onlinefamilypharmacy.com/mobileapplication/familypoints.php';
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    var luckyDrawUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=profilebelow_luckydraw';
    var luckyDrawUrlresponse =
        await http.post(Uri.parse(luckyDrawUrl), body: json.encode(data));

    List luckyDrawResponse = json.decode(luckyDrawUrlresponse.body);
    final luckyDrawList =
        luckyDrawResponse.map((item) => new LuckyDraw.fromJson(item)).toList();
    list = luckyDrawList;
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new FamilyPoints.fromJson(item)).toList();
  }

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String? user_id = prefs.getString('id');
    return user_id;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<FamilyPoints>>(
          future: _fetchFamilyPoints(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<FamilyPoints> data = snapshot.data ?? [];
              return getFamilyPointsWidget(context, data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}",
                  style: TextStyle(
                    fontFamily: "Roboto",
                  ));
            }
            return Center(
                child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
            ));
          },
        ));
  }

  getFamilyPointsWidget(context, List<FamilyPoints>? data) {
    return Stack(
      children: [
        Container(
            height: (data?.isEmpty ?? true) ? 0 : MediaQuery.of(context).size.height * 0.3,
            color: Colors.amber),
        Positioned(
            child: Container(
          child: Column(
            children: [
              for (int i=0; i<(data?.length ?? 0); i++)
                getCardView(data, i),
              SizedBox(
                height: 10,
              ),
              ...getLuckyDrawWidgets()
            ],
          )

          // ListView.builder(
          //   scrollDirection: Axis.vertical,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: data != null ? data.length : 0,
          //   itemBuilder: (context, index) {
          //     return
          //   },
          // ),
        )),
      ],
    );
  }

  Widget getCardView(data, index) {
    return Stack(children: <Widget>[
      Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                margin:
                EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 25),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://onlinefamilypharmacy.com/images/${data?[index].card}',
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 75,
                    ),
                    Text(
                      getCardNumber(
                          int.parse(data?[index].userId ?? "")),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          fontFamily: "Roboto",
                          color: Colors.white),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "VALID THRU",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.0,
                          fontFamily: "Roboto",
                          color: Colors.white),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data?[index].expiry ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: "Roboto",
                          color: Colors.white),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data?[index].firstName ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: "Roboto",
                          color: Colors.white),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
          ]),
      Column(
        children: [
          SizedBox(
            height: 180,
          ),
          Card(
              margin: EdgeInsets.all(10.0),
              color: Color(0xfff3f3f5),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${(double.parse(data?[index].familyPoints ?? "").toStringAsFixed(2))}",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30.0,
                            color: Colors.black,
                            fontFamily: "Roboto",
                          ),
                        ),

                        Text(
                          " = QAR ${(double.parse(data?[index].pointamount ?? "").toStringAsFixed(2))}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.black,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    BarcodeWidget(
                      barcode: Barcode.code128(escapes: true),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                        fontFamily: "Roboto",
                      ),
                      data: data?[index].userId ?? "",
                      drawText: false,
                      width: 250,
                      height: 60,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              //Html(data:"<p>Hello <b>Flutter</b><p>"),

                              Html(
                                data: data?[index].description ?? "",
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                },
                                child: Text(
                                  'EXTEND POINTS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff2e3192),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // <-- Radius
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => FamilyMilesHistory()));
              },
              child: Card(
                  color: Color(0xfff3f3f5),
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "View My points history  >",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: "Roboto",
                          color: Colors.black),
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))),
        ],
      ),
    ]);
  }
  List<Widget> getLuckyDrawWidgets() {
    final widgets = list?.map((e)  {
      return Card(
          color: Color(0xfff3f3f5),
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
            "🎁 ${e.drawName ?? ""}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 26.0,
                      fontFamily: "Roboto",
                      color: Colors.black),
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "DRAW DATE",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: "Perandory",
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  color: Color(0xff2e3192),
                  padding: EdgeInsets.symmetric(
                      vertical: 2, horizontal: 20),
                  child: Text(
                    e.drawDate ?? "",
                    maxLines: 4,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22.0,
                      color: Colors.white,
                      fontFamily: "Roboto",
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ));
    });
    return widgets?.toList() ?? [];
  }
  String getCardNumber(int number) {
    NumberFormat formatter = new NumberFormat("000000000000");
    final cardNumber = formatter.format(number);
    final value = cardNumber
        .toString()
        .replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ");

    return value;
  }
}
