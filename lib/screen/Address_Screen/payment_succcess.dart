import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/home_screen.dart';
import 'package:robustremedy/themes/light_color.dart';

class PaymentSuccessful extends StatefulWidget {
  PaymentSuccessful({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
  startTime() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, route);
  }

  route() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    var mediaQuery = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false) as bool,
      child: Scaffold(
        body: Container(
          width: mediaQuery.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Container(
                      height: 300,
                      child: ListView(
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 70.0,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Text(
                                    'Thank You! \n\nYour Order Has Been \n  Placed Successfully....!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: LightColor.midnightBlue,
                                        fontWeight: FontWeight.bold))),
                          ]))
                  // ),
                  ),
              Container(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme(
                      minWidth: width,
                      height: 70.0,
                      child:
                      ElevatedButton(onPressed:(){
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                                (Route<dynamic> route) => false);
                      },
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)), backgroundColor: LightColor.yellowColor),

                        child: Text("Continue Shopping",
                            style: TextStyle(
                                color: LightColor.midnightBlue,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
