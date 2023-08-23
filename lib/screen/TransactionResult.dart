import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';

import '../main.dart';
import 'Address_Screen/order_generated.dart';

class TransactionResult extends StatefulWidget{
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



  @override
  Widget build(BuildContext context) {
    
   return Scaffold(
       appBar: AppBar(
           title: Text("Result")),

     body: loading? CircularProgressIndicator() : Center(child: Text(result),),

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
      String url = "http://robustremedy.com:8080/paymentGatewayApi/ValidateTransaction";


      var response = await http.post(Uri.parse( url), body: jsonEncode(data));
      print("response " + response.body);
      var jsonResponse = jsonDecode(response.body);
      print(response.body);

      if (jsonResponse["msg"]["success"] == true) {
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
      dat['transaction_reference_no']=jsonResponse["msg"]["Reference"];
      int? orderId;

      saveTransaction(dat).then((value) {
        setState(() {
                    orderId = value;
                  });
      });

         Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => (Order_GeneratedScreen(orderId: orderId ?? 0,))));
        ScopedModel.of<CartModel>(context).clearCart();
                ScopedModel.of<CartModel>(context).calculateTotal();


    } catch (e) {
      print(e);
      Toast.show("SomeThing went wrong", duration: Toast.lengthShort,
          gravity: Toast.bottom);

      setState(() {
        loading = false;
      });
    }
  }

  Future<int>  saveTransaction(data)
  async{

    // print("saveTransaction"+data.toString());
    String url = 'https://onlinefamilypharmacy.com/mobileapplication/order_payment.php';

   var response = await http.post(Uri.parse( url), body: json.encode(data));
    return int.parse(response.body);

  }
  }


