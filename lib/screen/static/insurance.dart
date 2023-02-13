import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/screen/home/home_below_slider.dart';
import 'package:robustremedy/themes/colors.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/custom_divider_view.dart';
import 'package:url_launcher/url_launcher.dart';

class Job {
  final String url;
  final String title;
  final String type;
  final String preappLink;

  Job({this.url, this.title, this.type, this.preappLink});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      url: json['image'],
      title: json['title'],
      type: json['type'],
      preappLink: json['preapprovallink'],
    );
  }
}

class Insurance_Screen extends StatefulWidget {
  Insurance_Screen({Key key}) : super(key: key);

  @override
  State<Insurance_Screen> createState() => _Insurance_ScreenState();
}

class _Insurance_ScreenState extends State<Insurance_Screen> {
  Future<List<Job>> _fetchJobs() async {
    final jobsListAPIUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=ecommerceinsurance';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insurance"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Job>>(
          future: _fetchJobs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Job> data1 = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      constraints: new BoxConstraints.expand(
                                          height: 200.0, width: 450),
                                      alignment: Alignment.bottomLeft,
                                      padding: new EdgeInsets.only(
                                          left: 16.0, bottom: 8.0, top: 8.0),
                                      decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: new DecorationImage(
                                          image: new NetworkImage(
                                              'https://onlinefamilypharmacy.com/images/insurance/${data1[index].url}'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          data1[index].type == null
                                              ? Container(
                                                  padding: EdgeInsets.only(
                                                      left: 5,
                                                      right: 10,
                                                      top: 5,
                                                      bottom: 5),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .highlighterBlueDark,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  child: new Text(
                                                      'Pre Approval: ${data1[index].preappLink}',
                                                      style: new TextStyle(
                                                          fontSize: 12.0,
                                                          color: AppColors
                                                              .whiteColor)),
                                                )
                                              : InkWell(
                                                  onTap: () async {
                                                    await canLaunch(data1[index]
                                                            .preappLink)
                                                        ? await launch(
                                                            data1[index]
                                                                .preappLink)
                                                        : throw 'Could not launch ${data1[index].preappLink}';
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5,
                                                        right: 10,
                                                        top: 5,
                                                        bottom: 5),
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .highlighterBlueDark,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                    child: new Text(
                                                        ' Pre Approval: Login',
                                                        style: new TextStyle(
                                                            fontSize: 12.0,
                                                            color: AppColors
                                                                .whiteColor)),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${data1[index].title}',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        RichText(
                                          text: new TextSpan(
                                            text: '',
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  text:
                                                      'Documents Required - (Originals Only)\n',
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              new TextSpan(
                                                  text:
                                                      'Original Prescription \nValid Insurance Card\nDoctors Claim Form\nQatar ID'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]);
                        },
                        separatorBuilder: (context, index) {
                          return CustomDividerView();
                        },
                        itemCount: data1.length),
                    footerview()
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
                child: Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
              ),
            ));
          },
        ),
      ),
    );
  }
}
