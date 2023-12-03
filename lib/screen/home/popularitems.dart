import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';

import 'package:robustremedy/themes/light_color.dart';

class SummerItems extends StatefulWidget {
  @override
  _SummerItemsState createState() => _SummerItemsState();
}

class _SummerItemsState extends State<SummerItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SummerItemsDemo(),
    );
  }
}

class Job {
  final String? itemid;
  final String? img;
  final String? itemname_en;
  final String? labelname;
  final String? itempack;
  final String? itemstrength;
  final String? itemmaingrouptitle;
  final String? itemgrouptitle;
  final String? itemproductgrouptitle;
  final String? itemproductgroupimage;
  final String? type;
  final String? itemdosageid;
  final String? itemclassid;
  final String? manufactureshortname;
  final String? seq;
  final String? maxretailprice;
  final String? minretailprice;
  final String? rs;
  final String? origin;
  final String? whichcompany;
  final String? allowsonapp;
  final String? status;
  final String? shortdescription;
  final String? description;
  final String? additionalinformation;
  final String? itemproductgroupid;
  final String? itemgroupid;
  Job(
      {this.itemid,
        this.img,
        this.itemname_en,
        this.labelname,
        this.itempack,
        this.itemstrength,
        this.itemmaingrouptitle,
        this.itemgrouptitle,
        this.itemproductgrouptitle,
        this.itemproductgroupimage,
        this.type,
        this.itemdosageid,
        this.itemclassid,
        this.manufactureshortname,
        this.seq,
        this.maxretailprice,
        this.minretailprice,
        this.rs,
        this.origin,
        this.whichcompany,
        this.allowsonapp,
        this.status,
        this.shortdescription,
        this.description,
        this.additionalinformation,
        this.itemproductgroupid,
        this.itemgroupid});
//List data;
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
        itemid: json['itemid'],
        img: json['img'],
        itemname_en: json['itemname_en'],
        labelname: json['labelname'],
        itempack: json['itempack'],
        itemstrength: json['itemstrength'],
        itemmaingrouptitle: json['itemmaingrouptitle'],
        itemgrouptitle: json['itemgrouptitle'],
        itemproductgrouptitle: json['itemproductgrouptitle'],
        itemproductgroupimage: json['itemproductgroupimage'],
        type: json['type'],
        itemdosageid: json['itemdosageid'],
        itemclassid: json['itemclassid'],
        manufactureshortname: json['manufactureshortname'],
        seq: json['seq'],
        maxretailprice: json['maxretailprice'],
        minretailprice: json['minretailprice'],
        rs: json['rs'],
        origin: json['origin'],
        whichcompany: json['whichcompany'],
        allowsonapp: json['allowsonapp'],
        status: json['status'],
        shortdescription: json['shortdescription'],
        description: json['description'],
        additionalinformation: json['additionalinformation'],
        itemproductgroupid: json['itemproductgroupid'],
        itemgroupid: json['itemgroupid']);
  }
}

class SummerItemsDemo extends StatelessWidget {
  //List data;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Job> data = snapshot.data ?? [];
          return imageSlider(context, data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}", style: TextStyle(fontFamily: "Roboto"));
        }
        return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
            ));
      },
    );
  }
  late String epid;
  Future<List<Job>> _fetchJobs() async {
    var data = {
      'epid': 9
    };
    final jobsListAPIUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/ecommerceitemcode2.php';
    final response = await http.post(Uri.parse( jobsListAPIUrl), body: jsonEncode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

imageSlider(context, data) {
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListDetails(todo: data[index])));
            },
            child: Card(
                child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Container(
                        width: 100,
                        height: 100,
                        child: new Image.network(
                          'https://onlinefamilypharmacy.com/images/item/' +
                              data[index].img,
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
                          child: Text(data[index].itemproductgrouptitle,
                              textAlign: TextAlign.left,
                              // softWrap: true,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Roboto",
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
                          child: Text("\QR ${data[index].maxretailprice}",
                              textAlign: TextAlign.left,
                              // softWrap: true,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  color: LightColor.midnightBlue)),
                        )),
                  ]),
                )));
      },

      //   ),
      //   ),

//    ],
    );
}
