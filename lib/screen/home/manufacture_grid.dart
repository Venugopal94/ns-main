import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/screen/home/manufacture_list.dart';
import 'package:robustremedy/themes/light_color.dart';

class BrandGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Shop By Brand"),
        ),
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
  Brand({this.url,this.title,this.id});

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
          List<Brand> data = snapshot.data;
          return Grid(context, data);

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),));
      },
    );
  }

  Future<List<Brand>> _fetchJobs() async {
    final jobsListAPIUrl = 'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=manufacture';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Brand.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Grid(context,data) {
  final width = MediaQuery.of(context).size.width;
  final height=MediaQuery.of(context).size.height;
  if (height > 450 && width > 450 && width < 835  ) {
    //samsung tab vertical |
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.height / 3),
  crossAxisCount: 4),
  itemBuilder: (context, index) {

      return InkWell(
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) =>
                  BrandDetail(brandid: data[index].id,
                      brandtitle: data[index].title)));
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFFECEFF1),
                ),
                borderRadius: BorderRadius.circular(13),
                color: Colors.white,
              ),
              // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://onlinefamilypharmacy.com/images/manufacturerimages/' +
                          data[index].url, fit: BoxFit.fill,),

                  ],
                ),
              ),
              //  ),
            ),
          ),
        ),
      );


  }
    );     }
  else  if (width < 450) {
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
                    .height / 4.5),
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      BrandDetail(brandid: data[index].id,
                          brandtitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white,
                  ),
                  // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          'https://onlinefamilypharmacy.com/images/manufacturerimages/' +
                              data[index].url, fit: BoxFit.fill,),

                      ],
                    ),
                  ),
                  //  ),
                ),
              ),
            ),
          );
        }
    );
  }
  else
  if (width > 450 && width < 835) {
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
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      BrandDetail(brandid: data[index].id,
                          brandtitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white,
                  ),
                  // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          'https://onlinefamilypharmacy.com/images/manufacturerimages/' +
                              data[index].url, fit: BoxFit.fill,),

                      ],
                    ),
                  ),
                  //  ),
                ),
              ),
            ),
          );
        }
    );
  }
  else{
    //samsung A51 horizontal _____
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2.2),
            crossAxisCount: 4),
        itemBuilder: (context, index) {

          return InkWell(
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      BrandDetail(brandid: data[index].id,
                          brandtitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white,
                  ),
                  // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          'https://onlinefamilypharmacy.com/images//manufacturerimages/' +
                              data[index].url, fit: BoxFit.fill,),

                      ],
                    ),
                  ),
                  //  ),
                ),
              ),
            ),
          );


        }
    );     }
}



