import 'package:flutter/material.dart';
import 'package:robustremedy/screen/home/home_below_slider.dart';
import 'package:robustremedy/screen/home/home_joinus_view.dart';
import 'package:robustremedy/screen/home/home_slider.dart';
import 'package:robustremedy/widgets/AppDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:robustremedy/widgets/appdrawer_without_login.dart';
import 'package:robustremedy/widgets/custom_divider_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../themes/light_color.dart';

class PolicyScreen extends StatefulWidget {
  @override
  _PolicyStateScreen createState() => _PolicyStateScreen();
}

class _PolicyStateScreen extends State<PolicyScreen> {
  static const routeName = "/";

// Receiving Email using Constructor.
  String? email;

  void getData() async {
    SharedPreferences pf = await SharedPreferences.getInstance();

    setState(() {
      email = pf.getString("email") ?? "";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Privacy Policy", style: TextStyle(fontFamily: "Roboto",)),
        backgroundColor: LightColor.yellowColor,
        foregroundColor: LightColor.midnightBlue,
      ),
      drawer: email != null ? AppDrawer() : AppDrawer_without(),
      body: Policy(),
    );
  }
}

class StaticPage {
  final String? content;

  StaticPage({this.content});

  factory StaticPage.fromJson(Map<String, dynamic> json) {
    return StaticPage(
      content: json['content'],
    );
  }
}

class Policy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StaticPage>>(
      future: _fetchStaticPage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<StaticPage> data = snapshot.data ?? [];
          return imageSlider(context, data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}", style: TextStyle(fontFamily: "Roboto",));
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<StaticPage>> _fetchStaticPage() async {
    final jobsListAPIUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=e_staticpages_privacypolicy';
    final response = await http.get(Uri.parse( jobsListAPIUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new StaticPage.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

imageSlider(context, data) {
  return Container(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Html(
                  data: data[index].content,
                ),
              ),
              // Container(
              //   constraints: BoxConstraints.expand(height:190),
              //   child: SliderDemo(),
              // ),
              SizedBox(
                height: 20.0,
              ),
              CustomDividerView(),
              // joinusview(),

              // CustomDividerView(),
              footerview(),
            ]);
      },
    ),
  );
}
