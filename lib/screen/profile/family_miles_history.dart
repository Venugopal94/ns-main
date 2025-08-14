import 'dart:convert';
import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/home/home_below_slider.dart';
import 'package:robustremedy/screen/profile/address_profile.dart';
import 'package:robustremedy/screen/profile/account_details.dart';
import 'package:robustremedy/screen/profile/myorders.dart';
import 'package:robustremedy/screen/prescription/myprescriptions.dart';
import 'package:robustremedy/screen/static/logout.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/custom_divider_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login.dart';
import 'package:http/http.dart' as http;

import 'models/inventory_history.dart';

class FamilyMilesHistory extends StatefulWidget {
  @override
  _FamilyMilesHistoryState createState() => _FamilyMilesHistoryState();
}

class _FamilyMilesHistoryState extends State<FamilyMilesHistory> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<InventoryHistory>> _fetchInventoryHistory() async {
    String token = await getStringValues();
    var data = {'user_id': token};

    var url =
        'https://onlinefamilypharmacy.com/mobileapplication/billinginvoicehistory.php';
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    return jsonResponse
        .map((item) => new InventoryHistory.fromJson(item))
        .toList();
  }

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String? user_id = prefs.getString('id');
    return user_id;
  }

  void buildBarcode(Barcode bc,
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
        appBar: AppBar(title: Text("Family Miles History",  style: TextStyle(fontFamily: "Roboto")), backgroundColor: LightColor.yellowColor,
          foregroundColor: LightColor.midnightBlue,
        ),
        // backgroundColor: Colors.black12,
        body: FutureBuilder<List<InventoryHistory>>(
              future: _fetchInventoryHistory(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<InventoryHistory> data = snapshot.data ?? [];
                  return getInventoryHistoryWidget(context, data);
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

  getInventoryHistoryWidget(context, List<InventoryHistory>? data) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data != null ? data.length : 0,
        itemBuilder: (context, index) {
          return InkWell(
            child: Card(
              child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  _buildInventoryItem("Bill No.", data?[index].invoiceno ?? ""),
                  _buildInventoryItem("Bill Date", data?[index].invoicedate ?? ""),
                  _buildInventoryItem("Amount", data?[index].invoiceamount ?? ""),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }

  Widget _buildInventoryItem(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
            fontFamily: "Roboto",),
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
            fontFamily: "Roboto",),
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
