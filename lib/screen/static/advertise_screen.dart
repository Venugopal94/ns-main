import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/themes/colors.dart';
import 'package:robustremedy/themes/light_color.dart';

class Advertise_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advertise"),
        backgroundColor: LightColor.yellowColor,
      ),
      body: AdvertiseDemo(),
    );
  }
}

class Job {
  final String? url;
  final String? title;

  Job({this.url, this.title});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      url: json['image'],
      title: json['title'],
    );
  }
}

class AdvertiseDemo extends StatelessWidget {
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

  Future<List<Job>> _fetchJobs() async {
    final jobsListAPIUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=advertise';
    final response = await http.get(Uri.parse( jobsListAPIUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

imageSlider(context, data) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  final containerh = height / 2;
  if (width < 600) {
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 3.9),
            crossAxisCount: 1),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(5),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppColors.separatorGrey,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              color: AppColors.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      constraints:
                          new BoxConstraints.expand(height: 200.0, width: 450),
                      alignment: Alignment.bottomLeft,
                      padding: new EdgeInsets.only(
                          left: 16.0, bottom: 8.0, top: 8.0),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: new DecorationImage(
                          image: new NetworkImage(
                              'https://onlinefamilypharmacy.com/images/advertiseimages/' +
                                  data[index].url),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: 5, right: 10, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    color: LightColor.midnightBlue,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: new Text('Family Pharmacy',
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        color: AppColors.whiteColor)),
                              ),

                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 5, right: 10, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: AppColors.highlighterBlueDark,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: new Text( data[index].title,
                                style: new TextStyle(
                                    fontSize: 12.0, color: AppColors.whiteColor)),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        });
  }
  /* else{
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery
                .of(context)
                .size
                .width /
                (MediaQuery
                    .of(context)
                    .size
                    .height / 1.1),
            crossAxisCount: 1),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {

            },

         child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://onlinefamilypharmacy.com/images/advertiseimages/' +
                        data[index].url,
                    fit: BoxFit.fill,),


                ],
              ),
          ),
            //   ),
          );
        }
    );
  } */
}
