import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:robustremedy/screen/Item_group_screen/item_main.dart';
import 'package:robustremedy/screen/home/advertise.dart';
import 'package:robustremedy/screen/home/header.dart';
import 'package:robustremedy/screen/home/home_joinus_view.dart';
import 'package:robustremedy/screen/home/manufacture.dart';
import 'package:robustremedy/screen/home/manufacture_grid.dart';
import 'package:robustremedy/screen/home/home_category_maingroup.dart';
import 'package:robustremedy/screen/home/popularitems.dart';
import 'package:robustremedy/screen/home/summer_items.dart';
import 'package:robustremedy/screen/static/aboutus_detail.dart';
import 'package:robustremedy/screen/static/aboutus_intro.dart';
import 'package:robustremedy/screen/static/refer_earn.dart';
import 'package:robustremedy/screen/prescription/upload_prescription.dart';
import 'package:robustremedy/screen/tawkto.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:robustremedy/themes/ui_helper.dart';
import 'package:robustremedy/widgets/custom_divider_view.dart';
import 'package:share/share.dart';
import 'package:bouncing_widget/bouncing_widget.dart';

import 'header2.dart';

class home_below_SliderGrid extends StatelessWidget {
  final _pageController = PageController();
  // 20210726153817

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(4.0),
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Shop By Category",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.more,
                          color: LightColor.midnightBlue,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Item_main()));
                        },
                      )
                    ],
                  )),
              Container(
                //height: 175,
                constraints: BoxConstraints.expand(height: 175),
                child: ItemPage(),
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[100], width: 1.0),
                      top: BorderSide(color: Colors.grey[100], width: 1.0),
                    )),
                height: 70.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.chat,
                                    color: LightColor.midnightBlue,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WebViewExample()));
                                    // do something
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    'Chat with a Pharmacist Now',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        color: LightColor.midnightBlue),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ButtonTheme(
                          minWidth: 50.0,
                          height: 40.0,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebViewExample()));
                              // do something
                            },
                            color: LightColor.midnightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text("Chat",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          )),
                    ),
                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[100], width: 1.0),
                      top: BorderSide(color: Colors.grey[100], width: 1.0),
                    )),
                height: 150.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Order quickly with prescription',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        color: LightColor.midnightBlue),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            //finalprice=data[index].price,

                            Text(
                              "Upload Prescription and tell us what you need. ",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: LightColor.grey),
                            ),
                            Text(
                              'We do the rest!',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: LightColor.grey),
                            ),

                            SizedBox(height: 10),
                            ButtonTheme(
                                minWidth: 200.0,
                                height: 40.0,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Upload_prescription()));
                                  },
                                  color: LightColor.yellowColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text("Upload",
                                      style: TextStyle(
                                          color: LightColor.midnightBlue,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold)),
                                )),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        alignment: Alignment.topRight,
                        height: 110.0,
                        width: 110.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0)),
                            image: DecorationImage(
                                image: AssetImage('assets/upload.png'),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  ],
                ),
              ),
              CustomDividerView(),
              SizedBox(
                height: 20,
              ),
              Container(
                // height: 130,
                constraints: BoxConstraints.expand(height: 160),
                child: Advertise(),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[100], width: 1.0),
                      top: BorderSide(color: Colors.grey[100], width: 1.0),
                    )),
                height: 70.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Want to Know More ?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        color: LightColor.midnightBlue),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            //finalprice=data[index].price,
                            Text(
                              "Get in call with our Pharmacist",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: LightColor.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ButtonTheme(
                          minWidth: 50.0,
                          height: 40.0,
                          child: RaisedButton(
                            onPressed: _callNumber,
                            color: LightColor.yellowColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text("Call",
                                style: TextStyle(
                                    color: LightColor.midnightBlue,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          )),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                height: 800, // scroll mei hang ho rha hai .. // ok ?
                child: Header(),
              ),

              CustomDividerView(),
              aboutus_intro(),
              CustomDividerView(),

              Container(
                height: 400,
                child: Headerf(),
              ),

              SizedBox(
                height: 20.0,
              ),
              // Container(
              //     padding: EdgeInsets.all(4.0),
              //     alignment: Alignment.topLeft,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: <Widget>[
              //         Text(
              //           "Popular Items",
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, fontSize: 15),
              //         ),
              //         IconButton(
              //           padding: EdgeInsets.all(0),
              //           icon: Icon(
              //             Icons.more,
              //             color: Colors.white,
              //             size: 20,
              //           ),
              //           onPressed: () {},
              //         )
              //       ],
              //     )),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 175,
              //   child: PopularItems(),
              // ),
              //refern and earn
              /*  Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey[100], width: 1.0),
                          top: BorderSide(color: Colors.grey[100], width: 1.0),
                        )),
                    height: 150.0,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 110.0,
                            width: 110.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                                image: DecorationImage(
                                    image: AssetImage('assets/refericon.png'),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/goldcoin.jpg',
                                        height: 60,
                                        width: 60,
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.share,
                                          size: 30.0,
                                        ),
                                        onPressed: () {
                                          final RenderBox box =
                                              context.findRenderObject();
                                          Share.share(
                                              '\n\n Shop online on Qatar’s Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.' +
                                                  '\n\n https://www.onlinefamilypharmacy.com/ecommerce/public/productdetails.php?code=',
                                              subject: "this is the subject",
                                              sharePositionOrigin:
                                                  box.localToGlobal(
                                                          Offset.zero) &
                                                      box.size);
                                        },
                                      ),
                                    ]),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        'Refer & Earn',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                            color: LightColor.midnightBlue),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                //finalprice=data[index].price,

                                Text(
                                  "Invite friend to increase your wallet balance. ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: LightColor.grey),
                                ),

                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => referearn()));
                                  },
                                  child: Text(
                                    "Know More -> ",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: LightColor.midnightBlue),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),*/

              CustomDividerView(),
              Container(
                  padding: EdgeInsets.all(4.0),
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Shop By Brand",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.more,
                          color: LightColor.midnightBlue,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BrandGrid()));
                        },
                      )
                    ],
                  )),
              Container(
                height: 100,
                child: BrandPage(),
              ),
              footerview(),
            ],
          )
        ],
      ),
    );
  }
}

class SliderIndicator extends AnimatedWidget {
  final PageController pageController;
  final int indicatorCount;

  SliderIndicator({this.pageController, this.indicatorCount})
      : super(listenable: pageController);
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List<Widget>.generate(indicatorCount, buildIndicator));
  }

  Widget buildIndicator(int index) {
    final page = pageController.position.minScrollExtent == null
        ? pageController.initialPage
        : pageController.page;
    bool active = page.round() == index;
    print("build $index ${pageController.page}");
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: Center(
          child: Container(
              width: 20,
              height: 5,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }
}

class Job {
  final String url;

  Job({
    this.url,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      url: json['url'],
    );
  }
}

class GalleryDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Job> data = snapshot.data;
          return imageSlider(context, data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
        );
      },
    );
  }

  Future<List<Job>> _fetchJobs() async {
    final jobsListAPIUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/doctor_api.php?action=fetch_all';
    final response = await http.get(jobsListAPIUrl);

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
    //autoplay: true,
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return new Image.network(
        data[index].url,
        fit: BoxFit.fitWidth,
        width: 300,
      );
    },

    autoplay: true,
    viewportFraction: 0.4,
    scale: 0.5,
  );
}

_callNumber() async {
  const number = '+97470481616'; //set the number here
  bool res = await FlutterPhoneDirectCaller.callNumber(number);
}

class footerview extends StatelessWidget {
  const footerview({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.all(15.0),
      height: 350.0,
      color: Colors.grey[200],
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '#Always\nFamily',
                style: GoogleFonts.montserrat(
                  fontSize: 50.0,
                  letterSpacing: 0.2,
                  height: 1.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),
              UIHelper.verticalSpaceLarge(),
              Text(
                'Family Pharmacy',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.grey),
              ),
              Text(
                'Wanna stay healthy! Stay close to Family!',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.grey),
              ),
              UIHelper.verticalSpaceExtraLarge(),
              Row(
                children: <Widget>[
                  Container(
                    height: 1.0,
                    width: MediaQuery.of(context).size.width / 4,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          ),
          Positioned(
            left: 200.0,
            top: -40.0,
            child: Image.asset(
              'assets/scope.png',
              height: 250.0,
              width: 250.0,
            ),
          )
        ],
      ),
    );
  }
}
