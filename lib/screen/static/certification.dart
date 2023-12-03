import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:robustremedy/screen/home/home_below_slider.dart';
import 'package:robustremedy/themes/colors.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/themes/ui_helper.dart';
import 'package:robustremedy/widgets/custom_divider_view.dart';

class certification_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Certification", style: TextStyle(fontFamily: "Roboto",)),
        backgroundColor: LightColor.yellowColor,
        foregroundColor: LightColor.midnightBlue,
      ),
      body: AdvertiseDemo(),
    );
  }
}

class AdvertiseDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
            children: [
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                    child: Container(
                      width: 10.0,
                      height: 50.0,
                      color: LightColor.primaryBackground,
                    ),
                  ),
                  UIHelper.horizontalSpaceMedium(),
                  Flexible(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Certification',
                          style: GoogleFonts.montserrat(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        UIHelper.verticalSpaceSmall(),
                      ],
                    ),
                  )
                ],
              ),
              UIHelper.verticalSpaceMedium(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            constraints: new BoxConstraints.expand(
                                height: 500.0, width: 450),
                            alignment: Alignment.bottomLeft,
                            padding: new EdgeInsets.only(
                                left: 16.0, bottom: 8.0, top: 8.0),
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: new DecorationImage(
                                image: new NetworkImage(
                                    'https://onlinefamilypharmacy.com/images/c1.jpeg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            child: Container(
                                // padding: EdgeInsets.only(left: 15, right: 15),
                                // height: 300.0,
                                constraints: new BoxConstraints.expand(
                                    height: 500.0, width: 450),
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  child: Image.asset('assets/watermark.png'),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomDividerView(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            constraints: new BoxConstraints.expand(
                                height: 500.0, width: 450),
                            alignment: Alignment.bottomLeft,
                            padding: new EdgeInsets.only(
                                left: 16.0, bottom: 8.0, top: 8.0),
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: new DecorationImage(
                                image: new NetworkImage(
                                    'https://onlinefamilypharmacy.com/images/c2.jpeg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            child: Container(
                                // padding: EdgeInsets.only(left: 15, right: 15),
                                // height: 300.0,
                                constraints: new BoxConstraints.expand(
                                    height: 500.0, width: 450),
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  child: Image.asset('assets/watermark.png'),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomDividerView(),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                    child: Container(
                      width: 10.0,
                      height: 50.0,
                      color: LightColor.primaryBackground,
                    ),
                  ),
                  UIHelper.horizontalSpaceMedium(),
                  Flexible(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'ICV Certificate',
                          style: GoogleFonts.montserrat(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        UIHelper.verticalSpaceSmall(),
                      ],
                    ),
                  )
                ],
              ),
              UIHelper.verticalSpaceMedium(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            constraints: new BoxConstraints.expand(
                                height: 500.0, width: 450),
                            alignment: Alignment.bottomLeft,
                            padding: new EdgeInsets.only(
                                left: 16.0, bottom: 8.0, top: 8.0),
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: new DecorationImage(
                                image: new NetworkImage(
                                    'https://onlinefamilypharmacy.com/images/icv.jpg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            child: Container(
                                // padding: EdgeInsets.only(left: 15, right: 15),
                                // height: 300.0,
                                constraints: new BoxConstraints.expand(
                                    height: 500.0, width: 450),
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  child: Image.asset('assets/watermark.png'),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              footerview(),
            ],
          ),
        ),
      ),
    );
  }
}
