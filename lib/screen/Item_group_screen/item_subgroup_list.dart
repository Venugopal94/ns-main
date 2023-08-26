import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';
import 'package:robustremedy/screen/Item_group_screen/item_group.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/screen/Item_group_screen/item_subgroup.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'item_group_list.dart';

class SubList_Items extends StatefulWidget {
  final sublist;
  final title;

  SubList_Items({Key? key, @required this.sublist, @required this.title})
      : super(key: key);
  @override
  _SubList_ItemsState createState() => _SubList_ItemsState();
}

// class ItemGrpData {
//   final String itemid;
//   final String img;
//   final String itemname_en;
//   final String labelname;
//   final String itempack;
//   final String itemstrength;
//   final String itemmaingrouptitle;
//   final String itemgrouptitle;
//   final String itemproductgrouptitle;
//   final String itemproductgroupimage;
//   final String type;
//   final String itemdosageid;
//   final String itemclassid;
//   final String manufactureshortname;
//   final String seq;
//   final String maxretailprice;
//   final String minretailprice;
//   final String rs;
//   final String origin;
//   final String whichcompany;
//   final String allowsonapp;
//   final String status;
//   final String shortdescription;
//   final String description;
//   final String additionalinformation;
//   final String itemproductgroupid;
//   final String itemgroupid;
//   final String stock;
//   ItemGrpData(
//       {this.itemid,
//       this.img,
//       this.itemname_en,
//       this.labelname,
//       this.itempack,
//       this.itemstrength,
//       this.itemmaingrouptitle,
//       this.itemgrouptitle,
//       this.itemproductgrouptitle,
//       this.itemproductgroupimage,
//       this.type,
//       this.itemdosageid,
//       this.itemclassid,
//       this.manufactureshortname,
//       this.seq,
//       this.maxretailprice,
//       this.minretailprice,
//       this.rs,
//       this.origin,
//       this.whichcompany,
//       this.allowsonapp,
//       this.status,
//       this.shortdescription,
//       this.description,
//       this.additionalinformation,
//       this.itemproductgroupid,
//       this.itemgroupid,
//       this.stock});
//
//   factory ItemGrpData.fromJson(Map<String, dynamic> json) {
//     return ItemGrpData(
//         itemid: json['itemid'],
//         img: json['img'],
//         itemname_en: json['itemname_en'],
//         labelname: json['labelname'],
//         itempack: json['itempack'],
//         itemstrength: json['itemstrength'],
//         itemmaingrouptitle: json['itemmaingrouptitle'],
//         itemgrouptitle: json['itemgrouptitle'],
//         itemproductgrouptitle: json['itemproductgrouptitle'],
//         itemproductgroupimage: json['itemproductgroupimage'],
//         type: json['type'],
//         itemdosageid: json['itemdosageid'],
//         itemclassid: json['itemclassid'],
//         manufactureshortname: json['manufactureshortname'],
//         seq: json['seq'],
//         maxretailprice: json['maxretailprice'],
//         minretailprice: json['minretailprice'],
//         rs: json['rs'],
//         origin: json['origin'],
//         whichcompany: json['whichcompany'],
//         allowsonapp: json['allowsonapp'],
//         status: json['status'],
//         shortdescription: json['shortdescription'],
//         description: json['description'],
//         additionalinformation: json['additionalinformation'],
//         itemproductgroupid: json['itemproductgroupid'],
//         itemgroupid: json['itemgroupid'],
//         stock: json['stock']);
//   }
// }

class _SubList_ItemsState extends State<SubList_Items> {
  late List<ItemGrpData> data;
  String pharmacyname = "";
  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: TheSearch(data: data),
      query: pharmacyname,
    );
  }

  void _fetchdata() async {
    data = await _fetchItemGrpData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: LightColor.yellowColor,
        actions: [
          IconButton(
              onPressed: () {
                _showSearch();
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: FutureBuilder<List<ItemGrpData>>(
        future: _fetchItemGrpData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ItemGrpData> data = snapshot.data ?? [];
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<List<ItemGrpData>> _fetchItemGrpData() async {
    final url =
        'https://onlinefamilypharmacy.com/mobileapplication/categories/list_subgroup.php';
    var data = {'itemid': widget.sublist};
    var response = await http.post(Uri.parse( url), body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new ItemGrpData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Grid(context, data) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: data.length,
    itemBuilder: (context, index) {
      print("******************");
      print(data.length);
      return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListDetails(todo: data[index])));
          },
          // var finalprice = data[index].price;
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300] ?? Color(1), width: 1.5),
                    top: BorderSide(color: Colors.grey[300] ?? Color(1), width: 1.5),
                  )),
              height: 100.0,
              child: Row(
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        child: FadeInImage.assetNetwork(
                            placeholder: 'assets/noimage.jpeg',
                            image:
                                'https://onlinefamilypharmacy.com/images/item/' +
                                    data[index].img,
                            //image: 'https://picsum.photos/200',
                            fit: BoxFit.fitWidth,
                            width: 100),
                        alignment: Alignment.topLeft,
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5.0)
                          ],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                        ),
                      ),
                      Positioned(
                        top: 1,
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/watermark.png'),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                      child: Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Expanded(
                            child: Text(
                              data[index].itemproductgrouptitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                        SizedBox(height: 5),
                        Row(children: <Widget>[
                          Expanded(
                            child: Text(
                              data[index].itemmaingrouptitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0,
                                  color: LightColor.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                        SizedBox(height: 5),
                        getprice(double.parse(data[index].maxretailprice).toStringAsFixed(2),
                            double.parse(data[index].minretailprice).toStringAsFixed(2)),

                        /* Row(
      children: <Widget>[
                            Expanded(
                              child: Text(
                                data[index].minretailprice,
                                style: TextStyle(fontWeight: FontWeight
                                    .w600, fontSize: 15.0),overflow: TextOverflow.ellipsis,),
                            ),]),*/
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ));
    },
  );
}

getprice(max, min) {
  if (max == min) {
    return Row(children: <Widget>[
      Expanded(
        child: Text(
          "\QR ${max}",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: LightColor.midnightBlue),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  } else {
    return Row(children: <Widget>[
      Text(
        "\QR ${max}",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: LightColor.midnightBlue),
        overflow: TextOverflow.ellipsis,
      ),
      Text(" - "),
      Text(
        "\QR ${min}",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: LightColor.midnightBlue),
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }
}