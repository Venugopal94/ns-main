import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robustremedy/screen/Address_Screen/address_screen.dart';
import 'package:robustremedy/screen/prescription/myprescription_detail.dart';
import 'dart:io';
import 'dart:convert';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../profile/myorders_detail.dart';

class Prescriptions {
  final String? user_id;
  final String? doctor;
  final String? date;
  final String? id;
  final String? status;
  final String? statustitle;
  final String? user_comments;
  final String? admin_comments;
  final String? name;
  final String? contact;
  final String? zone;
  final String? patient_insured;
  final String? insurance_company;
  final String? insurance_company_approval_note_file_path;
  final String? insurance_card_file_path;
  final String? insurance_claim_file_path;
  final String? qatarid_file_path;
  final String? file_path;

  // final String email;
  Prescriptions({
    this.user_id,
    this.doctor,
    this.date,
    this.id,
    this.status,
    this.statustitle,
    this.user_comments,
    this.admin_comments,
    this.name,
    this.contact,
    this.zone,
    this.patient_insured,
    this.insurance_company,
    this.insurance_company_approval_note_file_path,
    this.insurance_card_file_path,
    this.insurance_claim_file_path,
    this.qatarid_file_path,
    this.file_path,
  });
//List data;
  factory Prescriptions.fromJson(Map<String, dynamic> json) {
    return Prescriptions(
      id: json['id'],
      user_id: json['user_id'],
      doctor: json['doctor'],
      date: json['date'],
      status: json['status'],
      statustitle: json['statustitle'],
      user_comments: json['user_comments'],
      admin_comments: json['admin_comments'],
      name: json['name'],
      contact: json['contact'],
      zone: json['zone'],
      patient_insured: json['patient_insured'],
      insurance_company: json['insurance_company'],
      insurance_company_approval_note_file_path:
          json['insurance_company_approval_note_file_path'],
      insurance_card_file_path: json['insurance_card_file_path'],
      insurance_claim_file_path: json['insurance_claim_file_path'],
      qatarid_file_path: json['qatarid_file_path'],
      file_path: json['file_path'],
    );
  }
}

class myprescription extends StatefulWidget {
  @override
  _myprescriptionState createState() => _myprescriptionState();
}

class _myprescriptionState extends State<myprescription> {
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String? user_id = prefs.getString('id');
    return user_id;
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart_>(context);
    return Scaffold(
      appBar: AppBar(title: Text("My Prescription")),
      body: FutureBuilder<List<Prescriptions>>(
        future: _fetchPrescriptions(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Prescriptions> data = snapshot.data ?? [];
            if (snapshot.data?.length == 0) {
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

  Future<List<Prescriptions>> _fetchPrescriptions() async {
    dynamic token = await getStringValues();
    print(token);
    var data = {'userid': token};
    var url =
        'https://onlinefamilypharmacy.com/mobileapplication/myprescriptions.php';
    var response = await http.post(Uri.parse( url), body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    print("Prescription");
    print(jsonResponse.toString());
    // _finalprice_= jsonResponse["price"].map((item) => new Item.fromJson(item)).toList();

    return jsonResponse
        .map((item) => new Prescriptions.fromJson(item))
        .toList();
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
                          return mypredetail(todo: data[index]);
                        })
                    //
                    );

                print(data[index].id);
                /*  Navigator.push(context,
                    new MaterialPageRoute(builder: (context) =>
                        mypredetail(todo:data[index]))
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
                                  "\  Prescription ID ",
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
                                    "\  Prescription Date ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      data[index].date,
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
                                  if (data[index].statustitle == "REJECTED")
                                    (Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Chip(
                                          backgroundColor: Colors.red,
                                          label: Text(
                                            data[index].statustitle,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )))
                                  else if (data[index].statustitle ==
                                      "PARTIAL_APPROVAL")
                                    (Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Chip(
                                          backgroundColor: Colors.yellow,
                                          label: Text(
                                            data[index].statustitle,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )))
                                  else if (data[index].statustitle ==
                                      "AWAITING_APPROVAL")
                                    (Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Chip(
                                          backgroundColor: Colors.blue,
                                          label: Text(
                                            'AWAITING APPROVAL',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )))
                                  else if (data[index].statustitle ==
                                      "APPROVED")
                                    (Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Chip(
                                          backgroundColor: Colors.green,
                                          label: Text(
                                            data[index].statustitle,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )))
                                  else if (data[index].statustitle ==
                                      "PROCESSED")
                                    (Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Chip(
                                          backgroundColor: Colors.green,
                                          label: Text(
                                            data[index].statustitle,
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
                                        data[index].statustitle,
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
