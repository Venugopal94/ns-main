import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/screen/Item_group_screen/detail_page.dart';
import 'package:robustremedy/screen/home/popularitems.dart';

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
          return Text("${snapshot.error}");
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
        'https://onlinefamilypharmacy.com/mobileapplication/ecommerceitemcode.php';
    final response = await http.post(Uri.parse( jobsListAPIUrl) ,body: jsonEncode(data));

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
