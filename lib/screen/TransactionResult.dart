import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';

import '../main.dart';
import '../themes/light_color.dart';
import 'Address_Screen/order_generated.dart';

class TransactionResult extends StatefulWidget {
  Uri uri;
  String token;
  var data;
  TransactionResult(this.uri,this.token, this.data);

  @override
  State<StatefulWidget> createState() {
    
    return TransactionResultState();
  }

}

class TransactionResultState extends State<TransactionResult> {
  bool loading=false;
  String result="";

  String noqoodyUrl = !isProd ? "https://sandbox.enoqoody.com" : "https://noqoodypay.com/sdk";


  @override
  Widget build(BuildContext context) {
    
   return Scaffold(
        backgroundColor: Colors.white,
       appBar: AppBar(
           title: Text("Result", style: TextStyle(fontFamily: "Roboto",)),
         backgroundColor: LightColor.yellowColor,
         foregroundColor: LightColor.midnightBlue,
       ),

     body: loading? Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),)) : Center(child: Text(result, style: TextStyle(fontFamily: "Roboto",)),),

   );
  }

  @override
  void initState() {
    ValidateTransaction();
    super.initState();
  }

  void ValidateTransaction() async {
    setState(() {
      loading = true;
    });
    var data = {
      "reference": this.widget.uri.queryParameters["reference"].toString(),
      "token": this.widget.token,
    };
    
    print(data);
    try {
      // String url="http://192.168.1.93:8080/paymentGatewayApi_war_exploded/ValidateTransaction";
      //old ip address of indore String url = "http://94.237.48.11:8080/paymentGatewayApi/ValidateTransaction";
      String url = "${noqoodyUrl}/api/Members/GetTransactionDetailStatusByClientReference/?ReferenceNo=${this.widget.uri.queryParameters["reference"].toString()}";
      var headers = {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer ${this.widget.token}",
        "Cookie": ".AspNet.Cookies=COfyR27l44Nz1Mepki_dkjGn9yvCSJFqsejdv-OwUVN-R3oP5ozuBPyTep27eEyOtw_pi-s7pf2PjIs1_c5nwycpI7404VIJDNdULorLtZI7l1kR2TFgmnHgiEAEn5e6715pyxPxamkKeoMN1X-hpR1d8-Bn_zYxn_8k4SIvkjbsSrYGlfST5ETQCBwGoPav_MD6OGqWEqTBP4bwk3ZzDHQW4JyEWwh-d17Rkmv_rJBagJnrm9_POpqiijnm6cLLZdSqEA4fYSotRXofVayRLG_f8NW-XtAsK12AgjDbkaEXWOQYBXOs6RzRQ5bz5K6NWRmk9KIjcpWw2g5Uza65jDUnPdoznuK_BpPaWiwxSzWH5VLi-8AbfcElT6eY6q9bKW0B4Vmjasb_mHnMJURQ5Ked5B9zzzBIN4LZOhoDLGBylbJXfRSO5eCefvnySj9b8WuSYeqN9QcyJriZpGy1tENtFrMthOe5IwfRkcVTyCtfFRNXjkpCDboYtf27eMODC-zP1Lo74CBNRyMEJoXi7A"
      };
      var response = await http.get(Uri.parse( url), headers: headers);
      print("response " + response.body);
      var jsonResponse = jsonDecode(response.body);
      print(response.body);

      if (jsonResponse["success"] == true) {
        setState(() {
          loading = false;
          result = "success";
        });
      }
      else {
        setState(() {
          loading = false;
          result = "failed";
        });
      }
      var dat=this.widget.data;
      dat['transaction_reference_no']= jsonResponse["Reference"];
      dat['status'] = result == "success" ? 2 : 3;
      int? orderId;

      await saveTransaction(dat).then((value) {
         orderId = value;
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => (Order_GeneratedScreen(orderId: result == "success" ? (orderId ?? 0) : 0,))));
      // Clear the cart only if the order is successful if not don't clear
      if (result == "success") {
        ScopedModel.of<CartModel>(context).clearCart();
        ScopedModel.of<CartModel>(context).calculateTotal();
      }
    } catch (e) {
      print(e);
      Toast.show("SomeThing went wrong", duration: Toast.lengthShort,
          gravity: Toast.bottom);
      setState(() {
        loading = false;
      });
    }
  }

  Future<int>  saveTransaction(data) async {
    String url = 'https://onlinefamilypharmacy.com/mobileapplication/order_payment.php';
   var response = await http.post(Uri.parse( url), body: json.encode(data));
    return int.parse(response.body);
  }
  }


