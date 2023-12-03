import 'package:flutter/material.dart';
import 'package:robustremedy/screen/home_screen.dart';

import 'package:robustremedy/screen/intro_screen/screen.dart';
import 'package:robustremedy/themes/light_color.dart';

class Order_GeneratedScreen extends StatefulWidget {
  final int orderId;
  Order_GeneratedScreen({Key? key, required this.orderId})
      : super(key: key);
  @override
  _Order_GeneratedScreenState createState() => _Order_GeneratedScreenState();
}

class _Order_GeneratedScreenState extends State<Order_GeneratedScreen>
    with SingleTickerProviderStateMixin {
  Animation<double>? opacity;
  AnimationController? controller;

  @override
  void initState() {
    super.initState();

    /*  controller = AnimationController(
        duration: Duration(seconds: 2), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });*/

    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => (HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false) as bool,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Confirmation", style: TextStyle(fontFamily: "Roboto")),
            backgroundColor: LightColor.yellowColor,
            foregroundColor: LightColor.midnightBlue,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            //   child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  /*  Opacity(
                    opacity: opacity.value,
                    child:*/
                  if (widget.orderId == 0)
                    Center(child: Container(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        "assets/payment_failed.png",
                      ),
                    )),
                  if (widget.orderId != 0)
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
                                          'Thank You! \n\nYour Order ${widget.orderId} Has Been \n  Placed Successfully....!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontFamily: "Roboto",
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: LightColor.yellowColor),

                            child: Text("Continue Shopping",
                                style: TextStyle(
                                    color: LightColor.midnightBlue,
                                    fontFamily: "Roboto",
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          )
                          ),
                    ),
                  ),
                ]),
          )),
    );
  }
}
