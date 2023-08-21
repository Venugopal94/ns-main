import 'dart:convert';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:robustremedy/screen/Item_group_screen/item_main.dart';
import 'package:robustremedy/screen/home/home_below_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:robustremedy/screen/home/home_category_maingroup.dart';
import 'package:robustremedy/screen/Item_group_screen/search_screen.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/AppDrawer.dart';

class SliderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        //AppDrawer(),

        Container(
            height: 60,
            decoration: BoxDecoration(color: LightColor.yellowColor),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 0, bottom: 12),
                child: TextFormField(
                  decoration: new InputDecoration(
                    hintText: "Search Medicines / Healthcare Products",
                    fillColor: Colors.white,
                    filled: true,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(color: LightColor.yellowColor),
                    ),
                  ),
                  //fillColor: Colors.green

                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserFilterDemo()));
                  },
                ))),
        if (width > 450 && width < 835)
          (Container(
            constraints: BoxConstraints.expand(height: 200),
            child: SliderDemo(),
          ))
        else if (width < 450)
          (Container(
            constraints: BoxConstraints.expand(height: 200),
            child: SliderDemo(),
          ))
        else
          (Container(
            constraints: BoxConstraints.expand(height: height / 2),
            child: SliderDemo(),
          )),
        Container(
          //  constraints: BoxConstraints.expand(
          //    height: 500
          //   ),
          child: home_below_SliderGrid(),
        ),
      ]),
    );
  }
}

class Job {
  final String image2;

  Job({
    required this.image2,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      image2: json['image2'],
    );
  }
}

class SliderDemo extends StatelessWidget {
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
        'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=slider';
    final response = await http.get(Uri(path: jobsListAPIUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Swiper imageSlider(context, data) {
  return new Swiper(
    autoplay: true,
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return new Image.network(
        'https://onlinefamilypharmacy.com/images/sliderimages/' + data[index].image2,
        fit: BoxFit.fitWidth,
        width: 300,
      );
    },
    pagination: SwiperPagination(),
    //viewportFraction: 0.2,

    scale: 1.0,
  );
}
