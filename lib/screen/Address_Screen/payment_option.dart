import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Webview.dart';
import 'package:robustremedy/screen/profile/account_details.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import '../../main.dart';
import 'Models/NoqoodyData.dart';
import 'Models/PaymentChannelsResponse.dart';
import 'order_generated.dart';

class PaymentOptionScreen extends StatefulWidget {
  int amount;
  var data;

  PaymentOptionScreen({Key? key, required this.amount, required this.data})
      : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}
enum PaymentMethod { paymentOnDelivery, noqoody, ipay }
class _PaymentScreenState extends State<PaymentOptionScreen> {

  int? selectedRadioTile, selectedRadio;

  late bool loading;
  String accessToken = "";
  String sessionId = "";
  String uuid = "";
  PaymentMethod paymentMethod = PaymentMethod.paymentOnDelivery;
  PaymentChannelsResponse? paymentChannelsResponse;
  List<String> paymentMethodsDelivery = ["Cash on Delivery", "Card on Delivery"];
  String noqoodyUrl =
      !isProd ? "https://sandbox.enoqoody.com" : "https://noqoodypay.com/sdk";

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
        backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Payment", style: TextStyle(fontFamily: "Roboto")),
        backgroundColor: LightColor.yellowColor,
        foregroundColor: LightColor.midnightBlue,
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
          child: loading
              ? Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Center(
                      child: Center(
                          child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
                  ))),
                )
              : Column(children: <Widget>[
                  Container(
                    color: Colors.grey,
                    padding: EdgeInsets.all(10.0),
                    child: Row(children: [
                      Text(
                        "Payment On Delivery",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Roboto",
                            color: LightColor.midnightBlue,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Column(children: <Widget>[
                        for (var i = 0; i < paymentMethodsDelivery.length; i++)
                          Card(
                              color: Colors.white,
                              child: RadioListTile(
                                value: i,
                                groupValue: paymentMethod == PaymentMethod.paymentOnDelivery ? selectedRadioTile : null,
                                title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        paymentMethodsDelivery[i],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Roboto",
                                            color: LightColor.midnightBlue,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                                // subtitle: Text("Radio 2 Subtitle"),
                                onChanged: (int? val) {
                                  print("Radio Tile pressed $val");
                                  paymentMethod = PaymentMethod.paymentOnDelivery;
                                  setSelectedRadioTile(val ?? 0);
                                },
                                activeColor: LightColor.midnightBlue,

                                selected: false,
                              )),
                      ]
                      )),
                  Container(
                    color: Colors.grey,
                    padding: EdgeInsets.all(10.0),
                    child: Row(children: [
                      Text(
                        "Credit/Debit/Papal",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Roboto",
                            color: LightColor.midnightBlue,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                  Container(
                      height: height,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Column(children: <Widget>[
                        for (var i = 0;
                            i <
                                (paymentChannelsResponse?.paymentChannels ?? [])
                                    .length;
                            i++)
                          Card(
                              color: Colors.white,
                              child: RadioListTile(
                                value: i,
                                groupValue: paymentMethod == PaymentMethod.noqoody ? selectedRadioTile : null,
                                title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        paymentChannelsResponse
                                                ?.paymentChannels?[i]
                                                .channelName ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Roboto",
                                            color: LightColor.midnightBlue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 70,
                                        alignment: Alignment.topRight,
                                        child: CachedNetworkImage(
                                          imageUrl: paymentChannelsResponse
                                                  ?.paymentChannels?[i]
                                                  .imageLocation ??
                                              "",
                                          height: 60,
                                          width: 120,
                                          placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    LightColor.midnightBlue),
                                          )),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ]),
                                // subtitle: Text("Radio 2 Subtitle"),
                                onChanged: (int? val) {
                                  print("Radio Tile pressed $val");
                                  paymentMethod = PaymentMethod.noqoody;
                                  setSelectedRadioTile(val ?? 0);
                                },
                                activeColor: LightColor.midnightBlue,

                                selected: false,
                              )),
                      ])),
                ]),
        ),
      ])),
      floatingActionButton: Container(
          height: 50.0,
          width: 150.0,
          //child: FittedBox(
          child: FloatingActionButton.extended(
            backgroundColor: LightColor.yellowColor,
            onPressed: () async {
              if (paymentMethod == PaymentMethod.paymentOnDelivery) {
                int? orderId;
                         await  payment().then((value) {
                            orderId = value;
                        });
                         Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) => (Order_GeneratedScreen(orderId: orderId ?? 0,))));
                ScopedModel.of<CartModel>(context).clearCart();
                ScopedModel.of<CartModel>(context).calculateTotal();
              } else {
                String? url = paymentChannelsResponse
                    ?.paymentChannels?[selectedRadioTile ?? 0].paymentURL;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WebViewLoad(url ?? "", accessToken, this.widget.data),
                    )).then((result) {
                  generatePaymentLinks();
                });
              }
            },
            // icon: Icon(Icons.save),
            label: Center(
                child: Text(
              "Confirm",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Roboto",
                  color: LightColor.midnightBlue,
                  fontWeight: FontWeight.bold),
            )),
          )),
    );
  }

  void getAccessToken(BuildContext context) async {
    String url = "${noqoodyUrl}/token";
    var data = {
      "grant_type": "password",
      "username": "familypharmacy",
      "password": "Fpg@#666626\$",
    };

    var headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "*/*",
      "Cookie":
          ".AspNet.Cookies=COfyR27l44Nz1Mepki_dkjGn9yvCSJFqsejdv-OwUVN-R3oP5ozuBPyTep27eEyOtw_pi-s7pf2PjIs1_c5nwycpI7404VIJDNdULorLtZI7l1kR2TFgmnHgiEAEn5e6715pyxPxamkKeoMN1X-hpR1d8-Bn_zYxn_8k4SIvkjbsSrYGlfST5ETQCBwGoPav_MD6OGqWEqTBP4bwk3ZzDHQW4JyEWwh-d17Rkmv_rJBagJnrm9_POpqiijnm6cLLZdSqEA4fYSotRXofVayRLG_f8NW-XtAsK12AgjDbkaEXWOQYBXOs6RzRQ5bz5K6NWRmk9KIjcpWw2g5Uza65jDUnPdoznuK_BpPaWiwxSzWH5VLi-8AbfcElT6eY6q9bKW0B4Vmjasb_mHnMJURQ5Ked5B9zzzBIN4LZOhoDLGBylbJXfRSO5eCefvnySj9b8WuSYeqN9QcyJriZpGy1tENtFrMthOe5IwfRkcVTyCtfFRNXjkpCDboYtf27eMODC-zP1Lo74CBNRyMEJoXi7A"
    };
    var response =
        await http.post(Uri.parse(url), body: data, headers: headers);
    var jsonResponse = jsonDecode(response.body);
    print("response " + response.body);
    try {
      setState(() {
        accessToken = jsonResponse['access_token'];
        loading = false;
        generatePaymentLinks();
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      Toast.show("SomeThing went wrong",
          duration: Toast.lengthShort, gravity: Toast.bottom);
    }
  }

  void generatePaymentLinks() async {
    reference = DateTime.now().millisecondsSinceEpoch;
    String url = "${noqoodyUrl}/api/PaymentLink/GenerateLinks";
    setState(() {
      loading = true;
    });
    try {
      var accountList = await _fetchaccount();
      var noqoodyData = await getNoqoodyDetails();
      Account account = accountList.first;
      String secret = noqoodyData.userProjects?.first.clientSecret ?? "";
      String message =
          '${account.email.toString()}${account.first_name?.trim()}${account.mobile.toString()}${noqoodyData.userProjects?.first.projectDescription ?? ""}${noqoodyData.userProjects?.first.projectCode ?? ""}${reference.toString()}';

      var key = utf8.encode(secret);

      var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
      var digest = base64Encode(hmacSha256.convert(message.codeUnits).bytes);

      var data = {
        "ProjectCode": noqoodyData.userProjects?.first.projectCode ?? "",
        "Description": noqoodyData.userProjects?.first.projectDescription ?? "",
        "Reference": reference.toString(),
        "Amount": this.widget.amount.toString(),
        "CustomerEmail": account.email?.trim(),
        "CustomerMobile": account.mobile.toString(),
        "CustomerName": account.first_name?.trim(),
        "SecureHash": digest
      };
      var headers = {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer $accessToken",
        "Cookie":
            ".AspNet.Cookies=COfyR27l44Nz1Mepki_dkjGn9yvCSJFqsejdv-OwUVN-R3oP5ozuBPyTep27eEyOtw_pi-s7pf2PjIs1_c5nwycpI7404VIJDNdULorLtZI7l1kR2TFgmnHgiEAEn5e6715pyxPxamkKeoMN1X-hpR1d8-Bn_zYxn_8k4SIvkjbsSrYGlfST5ETQCBwGoPav_MD6OGqWEqTBP4bwk3ZzDHQW4JyEWwh-d17Rkmv_rJBagJnrm9_POpqiijnm6cLLZdSqEA4fYSotRXofVayRLG_f8NW-XtAsK12AgjDbkaEXWOQYBXOs6RzRQ5bz5K6NWRmk9KIjcpWw2g5Uza65jDUnPdoznuK_BpPaWiwxSzWH5VLi-8AbfcElT6eY6q9bKW0B4Vmjasb_mHnMJURQ5Ked5B9zzzBIN4LZOhoDLGBylbJXfRSO5eCefvnySj9b8WuSYeqN9QcyJriZpGy1tENtFrMthOe5IwfRkcVTyCtfFRNXjkpCDboYtf27eMODC-zP1Lo74CBNRyMEJoXi7A"
      };
      log(account.mobile.toString());
      var response = await http.post(Uri.parse(url),
          body: jsonEncode(data), headers: headers);
      print("response " + response.body);
      var jsonResponse = jsonDecode(response.body);
      sessionId = jsonResponse["SessionId"];
      uuid = jsonResponse["Uuid"];
      var paymentLinks = await getPaymentLinks();
      setState(() {
        loading = false;
        paymentChannelsResponse = paymentLinks;
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
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new Account.fromJson(item)).toList();
  }

  Future<NoqoodyData> getNoqoodyDetails() async {
    var headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "*/*",
      "Authorization": "Bearer $accessToken",
      "Cookie":
          ".AspNet.Cookies=COfyR27l44Nz1Mepki_dkjGn9yvCSJFqsejdv-OwUVN-R3oP5ozuBPyTep27eEyOtw_pi-s7pf2PjIs1_c5nwycpI7404VIJDNdULorLtZI7l1kR2TFgmnHgiEAEn5e6715pyxPxamkKeoMN1X-hpR1d8-Bn_zYxn_8k4SIvkjbsSrYGlfST5ETQCBwGoPav_MD6OGqWEqTBP4bwk3ZzDHQW4JyEWwh-d17Rkmv_rJBagJnrm9_POpqiijnm6cLLZdSqEA4fYSotRXofVayRLG_f8NW-XtAsK12AgjDbkaEXWOQYBXOs6RzRQ5bz5K6NWRmk9KIjcpWw2g5Uza65jDUnPdoznuK_BpPaWiwxSzWH5VLi-8AbfcElT6eY6q9bKW0B4Vmjasb_mHnMJURQ5Ked5B9zzzBIN4LZOhoDLGBylbJXfRSO5eCefvnySj9b8WuSYeqN9QcyJriZpGy1tENtFrMthOe5IwfRkcVTyCtfFRNXjkpCDboYtf27eMODC-zP1Lo74CBNRyMEJoXi7A"
    };
    var url = '${noqoodyUrl}/api/Members/GetUserSettings';
    var response = await http.get(Uri.parse(url), headers: headers);
    var jsonResponse = json.decode(response.body);
    return NoqoodyData.fromJson(jsonResponse);
  }

  Future<PaymentChannelsResponse> getPaymentLinks() async {
    var headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "*/*",
      "Authorization": "Bearer $accessToken",
      "Cookie":
          ".AspNet.Cookies=COfyR27l44Nz1Mepki_dkjGn9yvCSJFqsejdv-OwUVN-R3oP5ozuBPyTep27eEyOtw_pi-s7pf2PjIs1_c5nwycpI7404VIJDNdULorLtZI7l1kR2TFgmnHgiEAEn5e6715pyxPxamkKeoMN1X-hpR1d8-Bn_zYxn_8k4SIvkjbsSrYGlfST5ETQCBwGoPav_MD6OGqWEqTBP4bwk3ZzDHQW4JyEWwh-d17Rkmv_rJBagJnrm9_POpqiijnm6cLLZdSqEA4fYSotRXofVayRLG_f8NW-XtAsK12AgjDbkaEXWOQYBXOs6RzRQ5bz5K6NWRmk9KIjcpWw2g5Uza65jDUnPdoznuK_BpPaWiwxSzWH5VLi-8AbfcElT6eY6q9bKW0B4Vmjasb_mHnMJURQ5Ked5B9zzzBIN4LZOhoDLGBylbJXfRSO5eCefvnySj9b8WuSYeqN9QcyJriZpGy1tENtFrMthOe5IwfRkcVTyCtfFRNXjkpCDboYtf27eMODC-zP1Lo74CBNRyMEJoXi7A"
    };
    var url =
        '${noqoodyUrl}/api/PaymentLink/PaymentChannels?session_id=$sessionId&uuid=$uuid';
    var response = await http.get(Uri.parse(url), headers: headers);
    var jsonResponse = json.decode(response.body);
    return PaymentChannelsResponse.fromJson(jsonResponse);
  }

  Future<int> payment() async {
    var mode_service;

    if ((selectedRadioTile == 0) || (selectedRadioTile == 1)) {
      if (selectedRadioTile == 0) {
        mode_service = 'Cash On Delivery';
      } else if (selectedRadioTile == 1){
        mode_service = 'Card On Delivery';
      }


      var data = widget.data;
      data["mode_service"] = mode_service;
      var url =
          'https://onlinefamilypharmacy.com/mobileapplication/order_payment.php';

      var response = await http.post(Uri.parse( url), body: json.encode(data));

      log(response.body);

      return int.parse(response.body);
    }

    return 0;
  }
}
