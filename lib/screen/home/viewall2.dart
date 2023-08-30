import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';
import 'package:robustremedy/screen/Item_group_screen/item_group.dart';
import 'package:robustremedy/screen/home/popularitems.dart';
import 'package:robustremedy/themes/light_color.dart';

import 'header.dart';

class viewAll2 extends StatefulWidget {
  String epid;
  viewAll2({Key? key, required this.epid}) : super(key: key);


  @override
  viewAll2State createState() => viewAll2State();
}

class viewAll2State extends State<viewAll2> {
  Future<List<Job>> _fetchItemData(_id) async {
    var data = {'epid': _id};
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

  late DateTime currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("View All"),
            backgroundColor: LightColor.yellowColor,
            foregroundColor: LightColor.midnightBlue,
          ),
          body:FutureBuilder<List<Job>>(
            future: _fetchItemData(widget.epid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Job> data = snapshot.data ?? [];
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
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(value),backgroundColor:LightColor.midnightBlue ,));
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
  else
  if (width < 450) {
    //samsung A51 vertical |
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.7),
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



