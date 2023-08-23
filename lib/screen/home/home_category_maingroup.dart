import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/screen/Item_group_screen/item_group.dart';
import 'package:robustremedy/themes/light_color.dart';

class ItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          child: ItemDemo(),
        )
    );
  }
}

class Job {
  final String url;
  final String title;
  final String id;
  Job({required this.url,required this.title,required this.id});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id:json['id'],
      url: json['image'],
      title:json['etitle'],
    );
  }
}
class ItemDemo extends StatelessWidget {
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
        return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),));
      },
    );
  }

  Future<List<Job>> _fetchJobs() async {
    final jobsListAPIUrl = 'https://onlinefamilypharmacy.com/mobileapplication/categories/itemmaingroup.php?action=itemmaingroup';
    final response = await http.get(Uri.parse( jobsListAPIUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
imageSlider(context,data) {
  return
    //new ListView(

    //children: <Widget>[
    // Container(
       // height: 175,
      ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) =>
                      ItemGroup(itemid:data[index].id,itemtitle:data[index].title)));
            },
             child: Card(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              width: 130,
                              height:130,
                              child:  new Image.network(
                                'https://onlinefamilypharmacy.com/images/itemmaingroupimages/'+data[index].url,
                                fit: BoxFit.fitWidth,
                                width:130 ,

                              )

                          ),
                          ButtonBar(
                              children: <Widget>[
                                Text(data[index].title,
                                    // softWrap: true,
                                    style:
                                    TextStyle(fontSize: 13, fontWeight: FontWeight.w400,color:Colors.black)),
                              ]
                          ),
                        ]
                    ),
                  )
              ));
          },

      //  ),
     // ),

   // ],

  );
}


