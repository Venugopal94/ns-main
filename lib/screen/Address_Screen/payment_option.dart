import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Webview.dart';
import 'package:robustremedy/screen/profile/account_details.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class PaymentOptionScreen extends StatefulWidget {
  int amount;
  var data;
  // PaymentOptionScreen( price, Map<String, dynamic> data) {
    
  //   this.amount = price;
  //   this.data = data;
  // }

  PaymentOptionScreen({Key? key, required this.amount, required this.data}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentOptionScreen> {
  int? selectedRadioTile, selectedRadio;

  late bool loading;
  String accessToken = "";

  int? reference;

  String? paypalLink,
      creditCardLink,
      cyberSecureLink,
      IBCardLink,
      NapsLink,
      MobileLink;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    getAccessToken(context);
    setState(() {
      loading = true;
    });
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      print(selectedRadioTile);
    });
  }

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String? user_id = prefs.getString('id');
    return user_id;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
          child: loading
              ? Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : Column(children: <Widget>[
                  Container(
                      height: height,
                      child: Column(children: <Widget>[
                        Card(
                            color: NapsLink == null
                                ? Colors.black12
                                : Colors.white,
                            child: RadioListTile(
                              value: 4,
                              groupValue: selectedRadioTile,
                              title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Debit Card",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: LightColor.midnightBlue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 70,
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                        "assets/naps.png",
                                        height: 60,
                                        width: 120,
                                      ),
                                    ),
                                    // Container(
                                    //   height: 50,width: 70,
                                    //   alignment: Alignment.topRight,
                                    //   child:Image.asset("assets/paypal.png",height: 60,width: 120,),),
                                  ]),
                              // subtitle: Text("Radio 2 Subtitle"),
                              onChanged: (int? val) {
                                if (NapsLink != null) {
                                  print("Radio Tile pressed $val");
                                  setSelectedRadioTile(val ?? 0);
                                }
                              },
                              activeColor: LightColor.midnightBlue,

                              selected: false,
                            )),
                        // Card(
                        //     color: cyberSecureLink==null?Colors.black12:Colors.white,
                        //     child:RadioListTile(
                        //       value: 1,
                        //       groupValue: selectedRadioTile,
                        //       title:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: <Widget>[

                        //             Text(
                        //               "Debit / Credit Card",
                        //               style: TextStyle(
                        //                   fontSize: 18,
                        //                   color: LightColor.midnightBlue,
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //             Container(
                        //               height: 50,width: 70,
                        //               alignment: Alignment.topRight,
                        //               child:Image.asset("assets/credit_card.png",height: 60,width: 120,),),]),
                        //       // subtitle: Text("Radio 2 Subtitle"),
                        //       onChanged: (val) {
                        //         if(cyberSecureLink!=null)
                        //         {
                        //           print("Radio Tile pressed $val");
                        //           setSelectedRadioTile(val);
                        //         }

                        //       },
                        //       activeColor: LightColor.midnightBlue,

                        //       selected: false,
                        //     )),
                        Card(
                            color: IBCardLink == null
                                ? Colors.black12
                                : Colors.white,
                            child: RadioListTile(
                              value: 2,
                              groupValue: selectedRadioTile,
                              title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Credit Card",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: LightColor.midnightBlue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 70,
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                        "assets/visa.png",
                                        height: 60,
                                        width: 120,
                                      ),
                                    ),
                                  ]),
                              // subtitle: Text("Radio 2 Subtitle"),
                              onChanged: (int? val) {
                                if (IBCardLink != null) {
                                  print("Radio Tile pressed $val");
                                  setSelectedRadioTile(val ?? 0);
                                }
                              },
                              activeColor: LightColor.midnightBlue,

                              selected: false,
                            )),
                        Card(
                            color: paypalLink == null
                                ? Colors.black12
                                : Colors.white,
                            child: RadioListTile(
                              value: 3,
                              groupValue: selectedRadioTile,
                              title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Paypal",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: LightColor.midnightBlue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 70,
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                        "assets/paypal.png",
                                        height: 60,
                                        width: 120,
                                      ),
                                    ),
                                  ]),
                              // subtitle: Text("Radio 2 Subtitle"),
                              onChanged: (int? val) {
                                if (paypalLink != null) {
                                  print("Radio Tile pressed $val");
                                  setSelectedRadioTile(val ?? 0);
                                }
                              },
                              activeColor: LightColor.midnightBlue,

                              selected: false,
                            )),

                        // Card(color:MobileLink==null?Colors.black12:Colors.white,
                        //     child: RadioListTile(
                        //       value: 5,
                        //       groupValue: selectedRadioTile,
                        //       title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: <Widget>[

                        //             Text(
                        //               "Mobile link",
                        //               style: TextStyle(
                        //                   fontSize: 18,
                        //                   color: LightColor.midnightBlue,
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //             // Container(
                        //             //   height: 50,width: 70,
                        //             //   alignment: Alignment.topRight,
                        //             //   child:Image.asset("assets/paypal.png",height: 60,width: 120,),),
                        //           ]),
                        //       // subtitle: Text("Radio 2 Subtitle"),
                        //       onChanged: (val) {
                        //         if(MobileLink==null)
                        //         {
                        //           print("Radio Tile pressed $val");
                        //           setSelectedRadioTile(val);
                        //         }

                        //       },
                        //       activeColor: LightColor.midnightBlue,

                        //       selected: false,
                        //     )),
                      ])),
                ]),
        ),
      ])),
      floatingActionButton: Container(
          height: 50.0,
          width: 150.0,
          //child: FittedBox(
          child: FloatingActionButton.extended(
            //  icon: Icon(Icons.add_shopping_cart),
            //  label: Text("Add to Cart"),
            backgroundColor: LightColor.yellowColor,
            onPressed: () {
              String? url = "";
              if (selectedRadioTile == 1) {
                url = cyberSecureLink;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WebViewLoad(url ?? "", accessToken, this.widget.data),
                    ));
              } else if (selectedRadioTile == 2) {
                url = IBCardLink;

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WebViewLoad(url ?? "", accessToken, this.widget.data),
                    ));

                // url = NapsLink;
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) =>
                //           WebViewLoad(url, accessToken, this.widget.data),
                //     ));
              } else if (selectedRadioTile == 3) {
                url = paypalLink;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WebViewLoad(url ?? "", accessToken, this.widget.data),
                    ));
              } else if (selectedRadioTile == 4) {
                url = NapsLink;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WebViewLoad(url ?? "", accessToken, this.widget.data),
                    ));
              }
            },
            // icon: Icon(Icons.save),
            label: Center(
                child: Text(
              "Confirm",
              style: TextStyle(
                  fontSize: 18,
                  color: LightColor.midnightBlue,
                  fontWeight: FontWeight.bold),
            )),
          )),
    );
  }

  void getAccessToken(BuildContext context) async {
    // String url="http://192.168.1.93:8080/paymentGatewayApi_war_exploded/GetAccessToken";
    String url =
        "http://robustremedy.com:8080/paymentGatewayApi/GetAccessToken";
    var response = await http.get(Uri(path: url));
    var jsonResponse = jsonDecode(response.body);
    print("response " + response.body);
    try {
      setState(() {
        accessToken = jsonResponse['msg']['access_token'];
        loading = false;
        reference = DateTime.now().millisecondsSinceEpoch;
        getPaymentLinks();
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      Toast.show("SomeThing went wrong",
          duration: Toast.lengthShort, gravity: Toast.bottom);
    }
  }

  void getPaymentLinks() async {
    // String url="http://192.168.1.93:8080/paymentGatewayApi_war_exploded/GetPaymentLinks";
    String url =
        "http://robustremedy.com:8080/paymentGatewayApi/GetPaymentLinks";
    setState(() {
      loading = true;
    });
    try {
      var accountList = await _fetchaccount();
      Account account = accountList.first;
      var data = {
        "reference": reference.toString(),
        "amount": this.widget.amount.toString(),
        "email": account.email?.trim(),
        "mobile": account.mobile.toString(),
        "name": account.first_name?.trim(),
        "token": accessToken
      };
      log(account.mobile.toString());
      var response = await http.post(Uri(path: url), body: jsonEncode(data));
      print("response " + response.body);
      var jsonResponse = jsonDecode(response.body);

      setState(() {
        paypalLink = jsonResponse["msg"]["PaypalLink"];
        creditCardLink = jsonResponse["msg"]["CreditCardLink"];
        cyberSecureLink = jsonResponse["msg"]["CyberSecureLink"];
        IBCardLink = jsonResponse["msg"]["IBCardLink"];
        NapsLink = jsonResponse["msg"]["NapsLink"];
        MobileLink = jsonResponse["msg"]["MobileLink"];
        loading = false;
      });
    } catch (e) {
      print(e);
      Toast.show("SomeThing went wrong",
          duration: Toast.lengthShort, gravity: Toast.bottom);

      setState(() {
        loading = false;
      });
    }
  }

  Future<List<Account>> _fetchaccount() async {
    dynamic token = await getStringValues();
    print(token);
    var data = {'userid': token};
    var url =
        'https://onlinefamilypharmacy.com/mobileapplication/account_details.php';
    var response = await http.post(Uri(path: url), body: json.encode(data));
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new Account.fromJson(item)).toList();
  }
}

