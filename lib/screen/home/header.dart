import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';
import 'package:robustremedy/screen/home/popularitems.dart';
import 'package:robustremedy/screen/home/viewAll.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'dart:convert';



class header {
  final String id;
  final String title;

  header(this.id, this.title);
}

class Header extends StatefulWidget {
  @override
  _headerstate createState() => _headerstate();

}

class _headerstate extends State<Header> {

  final String url =
      "https://onlinefamilypharmacy.com/mobileapplication/ecommercecategory.php";

  List<header> myAllData = [];
  loadData() async {
    var response = await http.get(Uri.parse( url), headers: {"Aceept": "application/json"});
    if (response.statusCode == 200) {
      String responeBody = response.body;
      var jsonBody = json.decode(responeBody);
      for (var data in jsonBody) {
        myAllData.add(new header(data['id'], data['title']));
      }

      setState(() {});

      myAllData.forEach((someData) => print("Name : ${someData.title}"));
    } else {
      print('Something went wrong');
    }
  }

  Future<List<Job>> fetchJobs(_id) async {
    var data = {'epid': _id};
    final jobsListAPIUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/ecommerceitemcode.php';
    final response = await http.post(Uri.parse( jobsListAPIUrl), body: jsonEncode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((job) => new Job.fromJson(job)).toList();

    } else {
      throw Exception('Failed to load jobs from API');
    }
  }


  @override
  void initState() {
    loadData();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: myAllData.length == 0
          ? new Center(
              child: new CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),

              ),
            )
          :  ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: myAllData.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 12.0),
                  child: Text(
                    myAllData[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Roboto"),
                  ),
                ),
                InkWell(
                  child: Text('See All', style:TextStyle(fontWeight: FontWeight.bold, fontFamily: "Roboto", color: LightColor.midnightBlue)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => viewAll(
                              epid: myAllData[index].id,
                            )));
                  },
                )
              ],
            ),
            subtitle: FutureBuilder<List<Job>>(
              future: fetchJobs(myAllData[index].id),
              builder: (context, snap) {
                if (snap.hasData) {
                  List<Job> items = snap.data ?? [];
                  return InkWell(
                    onTap: () {
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: items
                            .map((item) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ListDetails(todo: item)));
                          },
                          child: Container(
                            child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        child: FadeInImage.assetNetwork(
                                            placeholder:
                                            'assets/noimage.jpeg',
                                            image:
                                            'https://onlinefamilypharmacy.com/images/item/' +
                                                item!.img!,
                                            fit: BoxFit.fitWidth,
                                            width: 100),
                                        // child: Image.network(
                                        //   'https://onlinefamilypharmacy.com/images/item/' +
                                        //       item.img,
                                        //   fit: BoxFit.fitWidth,
                                        //   width: 100,
                                        // ),
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





                                  SizedBox(
                                      width: 120,
                                      height: 20,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                            item!.itemproductgrouptitle ?? "",
                                            textAlign: TextAlign.left,
                                            // softWrap: true,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.w400,
                                                fontFamily: "Roboto",
                                                color: LightColor
                                                    .midnightBlue)),
                                      )),
                                  SizedBox(
                                      width: 120,
                                      height: 20,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 15,
                                        ),
                                        child: Text(
                                            "\QR ${double.parse(item.maxretailprice ?? "").toStringAsFixed(2)}",
                                            textAlign: TextAlign.left,
                                            // softWrap: true,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontFamily: "Roboto",
                                                color: LightColor
                                                    .midnightBlue)),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ))
                            .toList(),
                      ),
                    ),
                  );
                }
                else if (snap.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
                ));
                }
                else if (snap.error != null){
                return Text("An Error occured", style: TextStyle(fontFamily: "Roboto"));
                }
                return Text("Loading.....", style: TextStyle(fontFamily: "Roboto"));
                // return Center(child: CircularProgressIndicator());
              },
            ),
          );
        })
    );
  }




}
