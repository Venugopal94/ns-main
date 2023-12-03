import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/screen/home/manufacture_list.dart';
import 'package:robustremedy/themes/light_color.dart';

class BrandPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          child: BrandDemo(),
        )
    );
  }
}

class Brand {
  final String url;
  final String title;
final String id;
  Brand({required this.url,required this.title,required this.id});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      url: json['image'],
      title:json['title'],
      id:json['id'],
    );
  }
}
class BrandDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Brand>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Brand> data = snapshot.data ?? [];
          return imageSlider(context, data);

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}", style: TextStyle(fontFamily: "Roboto"));
        }
        return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),));
      },
    );
  }

  Future<List<Brand>> _fetchJobs() async {
    final jobsListAPIUrl = 'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=manufacture';
    final response = await http.get(Uri.parse( jobsListAPIUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Brand.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
imageSlider(context,data) {
  return
 new ListView(

    children: <Widget>[
      Container(
        height: 90,
       child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return
            InkWell(
                onTap: () {
                  print(data[index].title);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      BrandDetail(brandid:data[index].id,brandtitle:data[index].title)));
            },
            child:Card(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              width: 140,
                              height:90,
                              child:  new Image.network(
                                'https://onlinefamilypharmacy.com/images/manufacturerimages/'+data[index].url,
                                fit: BoxFit.fitWidth,
                                //width:50 ,

                              )

                          ),

                        ]
                    ),
                  )
              )
            );
          },

       ),
    ),

   ],

  );
}


