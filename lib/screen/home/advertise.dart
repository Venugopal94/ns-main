import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class Advertise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:
          AdvertiseDemo(),

    );
  }
}

class Job {
  String url;
  final String title;

  Job({required this.url,required this.title});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      url: json['image'], title: '',
      //title:json['title'],
    );
  }
}
class AdvertiseDemo extends StatefulWidget {
  @override
  _AdvertiseDemoState createState() => _AdvertiseDemoState();
}

class _AdvertiseDemoState extends State<AdvertiseDemo> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
    var android= AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios= DarwinInitializationSettings();
    var initialise= InitializationSettings(android:android, iOS:ios );
    flutterLocalNotificationsPlugin.initialize(initialise);
  }
Future onSelectionNotification(String payload) async{
    if(payload != null){
      debugPrint("Notification :" +payload);
    }
}

Future showNotification() async{
    var android = AndroidNotificationDetails('channelId', 'Online Family Pharmacy');
    var ios= DarwinNotificationDetails();
    var platform= NotificationDetails(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.show(0, 'Online Family Pharmacy | Buy medicines online at best price in Qatar', 'Shop online on Qatars Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.',platform,payload:'some details');
}
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Job>? data = snapshot.data;
          return imageSlider(context, data);

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),));
      },
    );
  }

  Future<List<Job>> _fetchJobs() async {
    final jobsListAPIUrl = 'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=advertise';
    final response = await http.get(Uri.parse( jobsListAPIUrl));

    if (response.statusCode == 200) {
     //showNotification();
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
imageSlider(context,data) {
  return
   /* new ListView(

    children: <Widget>[
      Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
        height: 120,*/
      ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                 // child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ClipRRect(

                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                             // border: Border.all(color:Colors.blue ),


                              //width: 205,

                              child:  new Image.network(
                                'https://onlinefamilypharmacy.com/images/advertiseimages/'+data[index].url,
                                fit: BoxFit.fitHeight,
                                 width: 205,
                                height:150,
                              )

                          ),

                        ]
                    ),
                 // )
              );
          },

     //   ),
   //   ),

  //  ],

  );
}


