import 'dart:convert';
import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/profile/lucky_draw_banners.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../widgets/barcode/barcode_widget.dart';
import 'models/coupon.dart';
import 'models/inventory_history.dart';

class CouponsPage extends StatefulWidget {
  @override
  _CouponsPageState createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Coupon>> _fetchInventoryHistory() async {
    String token = await getStringValues();
    var data = {'user_id': token};

    var url = 'https://onlinefamilypharmacy.com/mobileapplication/coupons.php';
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new Coupon.fromJson(item)).toList();
  }

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String? user_id = prefs.getString('id');
    return user_id;
  }

  void buildBarcode(
    Barcode bc,
    String data, {
    String? filename,
    double? width,
    double? height,
    double? fontHeight,
  }) {
    /// Create the Barcode
    final svg = bc.toSvg(
      data,
      width: width ?? 200,
      height: height ?? 80,
      fontHeight: fontHeight,
    );

    // Save the image
    filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
    File('$filename.svg').writeAsStringSync(svg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Coupons",
              style: TextStyle(fontFamily: "Roboto")),
          backgroundColor: LightColor.yellowColor,
          foregroundColor: LightColor.midnightBlue,
        ),
        // backgroundColor: Colors.black12,
        body: FutureBuilder<List<Coupon>>(
          future: _fetchInventoryHistory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Coupon> data = snapshot.data ?? [];
              return getCouponWidget(context, data);
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

  getCouponWidget(context, List<Coupon>? data) {
    return Column(
      children: [
        Container(
          height: 200,
            child:
        LuckyDrawBanners()),
      Expanded(child:
      ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data != null ? data.length : 0,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://onlinefamilypharmacy.com/images/${data?[index].couponimage ?? ""}',
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RotatedBox(
                      quarterTurns: 1,
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          width: 160,
                          child: Center(
                              child: BarcodeWidget(
                            barcode: Barcode.code128(escapes: true),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                              fontFamily: "Roboto",
                            ),
                            data: data?[index].coupon ?? "",
                            width: 100,
                            height: 60,
                          )))),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "🎁 ${data?[index].drawName ?? ""}",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18.0,
                              fontFamily: "Perandory",
                            ),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${data?[index].description ?? ""}",
                            maxLines: 4,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0,
                              fontFamily: "Roboto",
                            ),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data?[index].drawTitle ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0,
                                        fontFamily: "Perandory",
                                      ),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      data?[index].luckyDrawItems ?? "",
                                      maxLines: 4,
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12.0,
                                        fontFamily: "Roboto",
                                      ),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "DRAW DATE",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0,
                                        fontFamily: "Perandory",
                                      ),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Container(
                                      color: Color(0xff2e3192),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 8),
                                      child: Text(
                                        data?[index].drawdate ?? "",
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 12.0,
                                          color: Colors.white,
                                          fontFamily: "Roboto",
                                        ),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Bill Date :",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 8.0,
                                            fontFamily: "Perandory",
                                          ),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          (data?[index].billdate ?? '')
                                              .split(" ")
                                              .first,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 8.0,
                                            fontFamily: "Perandory",
                                          ),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Valid From :",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 8.0,
                                            fontFamily: "Perandory",
                                          ),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          (data?[index].validfrom ?? '')
                                              .split(" ")
                                              .first,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 8.0,
                                            fontFamily: "Perandory",
                                          ),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Bill No :",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 8.0,
                                            fontFamily: "Perandory",
                                          ),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          (data?[index].billno ?? ''),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 8.0,
                                            fontFamily: "Perandory",
                                          ),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Valid Till :",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 8.0,
                                            fontFamily: "Perandory",
                                          ),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          (data?[index].validtill ?? ''),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 8.0,
                                            fontFamily: "Perandory",
                                          ),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(
                            "          ${(data?[index].coupon ?? '')}       ",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15.0,
                              fontFamily: "Roboto",
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ))
                ],
              ));
        },
      )),
      ],
    );
  }
}
