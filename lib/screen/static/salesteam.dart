import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/static/All_branch_details.dart';
import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';
import 'package:robustremedy/themes/light_color.dart';

import 'package:robustremedy/widgets/AppDrawer.dart';

class Salesteam extends StatefulWidget {
  @override
  _All_branchState createState() => _All_branchState();
}

class _All_branchState extends State<Salesteam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(" Sales Team "),
        backgroundColor: LightColor.yellowColor,
      ),
      drawer: AppDrawer(),
      body: AllBranch(),
    );
  }
}

class AllBranch extends StatefulWidget {
  @override
  _AllBranchState createState() => _AllBranchState();
}

class allbranch {
  final String? id;
  final String? name;
  final String? mobileno;
  final String? emailid;
  final String? designation;
  final String? post;
  final String? img;
  allbranch(
      {this.id,
      this.name,
      this.mobileno,
      this.emailid,
      this.designation,
      this.post,
      this.img});

  factory allbranch.fromJson(Map<String, dynamic> json) {
    return allbranch(
      id: json['id'],
      name: json['name'],
      mobileno: json['mobileno'],
      emailid: json['emailid'],
      designation: json['designation'],
      post: json['post'],
      img: json['img'],
    );
  }
}

class _AllBranchState extends State<AllBranch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<allbranch>>(
        future: _fetchallbranch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<allbranch> data = snapshot.data ?? [];
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<List<allbranch>> _fetchallbranch() async {
    final url =
        'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=salesteam';
    //var data = {'itemid': widget.itemnull};
    var response = await http.get(Uri.parse( url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new allbranch.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Grid(context, data) {
  return GridView.builder(
    scrollDirection: Axis.vertical,
    itemCount: data.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 3.5),
        crossAxisCount: 1),
    itemBuilder: (context, index) {
      return InkWell(

          child: Card(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300] ??  Color(1), width: 1.5),
                        top: BorderSide(color: Colors.grey[300] ?? Color(1), width: 1.5),
                      )),
                  height: 100.0,
                  child: Row(children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      height: 200.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5.0)
                          ],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://onlinefamilypharmacy.com/images/salesman/' +
                                      data[index].img),
                              fit: BoxFit.fill)),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 15.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Text(
                                data[index].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.0),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: <Widget>[
                              Text(
                                data[index].emailid,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                    color: LightColor.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: <Widget>[
                              Text(
                                data[index].mobileno,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                    color: LightColor.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Text(
                                data[index].post,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 6,
                              ),
                            ),
                          ]),
                    )),
                  ]))));
    },
  );
}
