import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';
import 'package:robustremedy/screen/Item_group_screen/item_group.dart';
import 'package:robustremedy/themes/light_color.dart';

import 'header.dart';

class viewAll extends StatefulWidget {
  String epid;
  viewAll({Key key, @required this.epid}) : super(key: key);


  @override
  viewAllState createState() => viewAllState();
}

class viewAllState extends State<viewAll> {
  Future<List<Job>> _fetchItemData(_id) async {
    var data = {'epid': _id};
    final jobsListAPIUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/ecommerceitemcode.php';
    final response = await http.post(jobsListAPIUrl, body: jsonEncode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  DateTime currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("View All"),
        ),
        body:FutureBuilder<List<Job>>(
          future: _fetchItemData(widget.epid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Job> data = snapshot.data;
              return Grid(context, data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),));
          },
        )


      );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      var message='exit_warning';
      showInSnackBar(message);
      SystemNavigator.pop();
      // Fluttertoast.showToast(msg: exit_warning);
      return Future.value(false);
    }
    return Future.value(true);
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value),backgroundColor:LightColor.midnightBlue ,));
  }
}

class Job {
  final String itemid;
  final String img;
  final String itemname_en;
  final String labelname;
  final String itempack;
  final String itemstrength;
  final String itemmaingrouptitle;
  final String itemgrouptitle;
  final String itemproductgrouptitle;
  final String itemproductgroupimage;
  final String type;
  final String itemdosageid;
  final String itemclassid;
  final String manufactureshortname;
  final String seq;
  final String maxretailprice;
  final String minretailprice;
  final String rs;
  final String origin;
  final String whichcompany;
  final String allowsonapp;
  final String status;
  final String shortdescription;
  final String description;
  final String additionalinformation;
  final String itemproductgroupid;
  final String itemgroupid;
  final String stock;
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
        this.itemgroupid,
      this.stock});
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
        itemgroupid: json['itemgroupid'],
        stock: json['stock']);
  }
}

// class GridDemo extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return FutureBuilder<List<Job>>(
//       future: _fetchItemData(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           List<Job> data = snapshot.data;
//           return Grid(context, data);
//         } else if (snapshot.hasError) {
//           return Text("${snapshot.error}");
//         }
//         return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),));
//       },
//     );
//   }
//
//   Future<List<Job>> _fetchItemData(_id) async {
//     var data = {'epid': _id};
//     final jobsListAPIUrl =
//         'https://onlinefamilypharmacy.com/mobileapplication/ecommerceitemcode.php';
//     final response = await http.post(jobsListAPIUrl, body: jsonEncode(data));
//
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((job) => new Job.fromJson(job)).toList();
//     } else {
//       throw Exception('Failed to load jobs from API');
//     }
//   }
// }
Grid(context,data) {
  final width = MediaQuery.of(context).size.width;
  final height=MediaQuery.of(context).size.height;
  final containerh= height/2;
  if (height > 450 && width > 450 && width < 835  ) {
    //samsung tab vertical |
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1),
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      ListDetails(todo: data[index]))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                //  height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFFECEFF1),
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network('https://onlinefamilypharmacy.com/images/item/'+data[index].img,    height: containerh / 2.5,
                      width: width / 2,),
                    Container(
                      height: containerh / 15, width: width / 2,
                      child: Text(
                        data[index].title, textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ),
            ),
          );
        }
    );
  }
  else
  if (width > 450 && width < 835) {
    //samsung A51 horizontal _____
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.5),
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      ListDetails(todo: data[index]))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13), color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network('https://onlinefamilypharmacy.com/images/item/'+data[index].img, height: containerh / 1.5,
                        width: width / 2,),
                      Container(
                        height: containerh / 10, width: width / 2,
                        child: Text(
                          data[index].itemproductgrouptitle, textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(
                          width: 120,
                          height: 20,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                            ),
                            child: Text(
                                "\QR  ${data[index].maxretailprice}",
                                textAlign: TextAlign.left,
                                // softWrap: true,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight:
                                    FontWeight.bold,
                                    color: LightColor
                                        .midnightBlue)),
                          )),

                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
  else
  if (width < 450) {
    //samsung A51 vertical |
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.5),
            crossAxisCount: 3),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // print(data[index].id);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      ListDetails(todo: data[index])  )

              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13), color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network('https://onlinefamilypharmacy.com/images/item/'+data[index].img, height: containerh / 3.5,
                        width: width / 2,),
                      Container(
                        height: containerh / 21, width: width / 2,
                        child: Text(
                          data[index].itemproductgrouptitle, textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(
                          width: 120,
                          height: 20,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                            ),
                            child: Text(
                                "\QR  ${data[index].maxretailprice}",
                                textAlign: TextAlign.left,
                                // softWrap: true,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight:
                                    FontWeight.bold,
                                    color: LightColor
                                        .midnightBlue)),
                          )),

                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
  else {
    //samsung A51 horizontal _____
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.45),
            crossAxisCount: 5),

        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      ListDetails(todo: data[index]))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //  height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13), color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network('https://onlinefamilypharmacy.com/images/itemmaingroupimages/'+data[index].url, height: containerh / 1.5,
                        width: width / 2,),
                      Container(
                        height: containerh / 10, width: width / 2,
                        child: Text(
                          data[index].title, textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}



