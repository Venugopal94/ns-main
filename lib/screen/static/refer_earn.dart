

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class CallsAndMessagesService {
  void call(String number) => launch("tel:$number");
  void sendSms(String number) => launch("sms:$number");
  void sendEmail(String email) => launch("mailto:$email");
}
class referearn extends StatefulWidget {

  @override
  _referearnState createState() => _referearnState();
}

class _referearnState extends State<referearn> {
  final String email = "dancamdev@example.com";
  //final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  //GetIt locator = GetIt();

  void setupLocator() {
    //locator.registerSingleton(CallsAndMessagesService());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        appBar: AppBar(
          title: Text('Refer & Earn'),
        ),
        body: Column(
            children: <Widget>[
        Expanded(
        child: Container(
            child: Column(children: <Widget>[
              Image.asset('assets/refer.jpg',),
SizedBox(height: 20,),

            /*  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        height: 70.0,
                        width: 70.0,
                        //color:Colors.green ,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                            ),
                            color:Colors.green ,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: FittedBox(
                            child: RaisedButton(
                              //  icon: Icon(Icons.add_shopping_cart),
                              //  label: Text("Add to Cart"),
                             color: Colors.green,
                                onPressed: () {

                                  FlutterOpenWhatsapp.sendSingleMessage("+97470481616", "I want to purchase this Product...");

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child:Icon(FontAwesomeIcons.whatsapp, size: 100.0,
                                      color: Colors.white),
                                    //child: Icon: FaIcon(FontAwesomeIcons.whatsapp),
                                    // label: Text(""),
                                  ),
                                ) ))),
                    Container(
                        height: 50.0,
                        width: 50.0,
                        //child: FittedBox(
                        child: FittedBox(
                            child: RaisedButton(
                              //  icon: Icon(Icons.add_shopping_cart),
                              //  label: Text("Add to Cart"),
                                color: Colors.green,
                                onPressed: () {

                                 // _service.sendEmail(email)
                                },
                                child: Center(child:Icon(FontAwesomeIcons.whatsapp, size: 100.0,
                                    color: Colors.white),
                                  //child: Icon: FaIcon(FontAwesomeIcons.whatsapp),
                                  // label: Text(""),
                                ) ))),


                  ]),*/

              ])))
            ])
    );
  }
}