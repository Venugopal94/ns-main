import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:robustremedy/screen/profile/change_pwd.dart';
import 'dart:convert';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account {
  final String? user_id;
  final String? pass;
  final String? first_name;
  final String? last_name;
  final String? mobile;
  final String? email;

  Account(
      {this.user_id,
      this.pass,
      this.first_name,
      this.last_name,
      this.mobile,
      this.email});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      user_id: json['user_id'],
      pass: json['pass'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      mobile: json['mobile'],
      email: json['email'],
    );
  }
}

class myaccount extends StatefulWidget {
  @override
  _myaccountState createState() => _myaccountState();
}

class _myaccountState extends State<myaccount> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? firstname, lastname, email, mobile;
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('id');
    return user_id;
  }

  Future update_acc() async {
    dynamic token = await getStringValues();

    // SERVER API URL
    var url =
        'https://onlinefamilypharmacy.com/mobileapplication/update_account_details.php';
    print(firstname);
    print(lastname);
    print(email);
    print(mobile);
    // Store all data with Param Name.
    var data = {
      'userid': token,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'mobile': mobile
    };

    // Starting Web API Call.
    var response = await http.post(Uri.parse( url), body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    showInSnackBar(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text("My Account", style: TextStyle(fontFamily: "Roboto",)), backgroundColor: LightColor.yellowColor,
            foregroundColor: LightColor.midnightBlue),
        body: FutureBuilder<List<Account>>(
          future: _fetchaccount(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Account> data = snapshot.data ?? [];
              if (snapshot.data?.length == 0) {
                return Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 80));
                    //child: Image.asset("assets/cart.png"));
              }

              return imageSlider(context, data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}", style: TextStyle(fontFamily: "Roboto",));
            }
            return Center(
                child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
            ));
          },
        ),
        floatingActionButton: Container(
            height: 50.0,
            width: 150.0,
            //child: FittedBox(
            child: FloatingActionButton.extended(
              //  icon: Icon(Icons.add_shopping_cart),
              //  label: Text("Add to Cart"),
              backgroundColor: LightColor.yellowColor,
              onPressed: () {
                update_acc();
              },
              // icon: Icon(Icons.save),
              label: Center(
                  child: Text(
                "Update",
                style: TextStyle(
                    fontSize: 18,
                    color: LightColor.midnightBlue,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold),
              )),
            )));
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(value, style: TextStyle(fontFamily: "Roboto",)),
      backgroundColor: LightColor.midnightBlue,
    ));
  }

  Future<List<Account>> _fetchaccount() async {
    dynamic token = await getStringValues();
    print(token);
    var data = {'userid': token};
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/account_details.php';
    var response = await http.post(Uri.parse( url), body: json.encode(data));
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new Account.fromJson(item)).toList();
  }

  imageSlider(context, data) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          firstname = data[index].first_name;
          lastname = data[index].last_name;
          email = data[index].email;
          mobile = data[index].mobile;
print(mobile);
          return InkWell(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "\  First Name ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15.0, fontFamily: "Roboto",),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: Container(
                            height: 45,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].first_name,
                                // controller: firstnameController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                onChanged: (text) {
                                  firstname = text;
                                },
                              ),
                            ),
                          ),
                          color: Colors.white38,
                        ),
                        /* Card(
                          child: Container(
                              height: 45,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                      data[index].first_name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.0),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                  ),

                           Padding(
                                    padding: const EdgeInsets.only(left: 10),

                                  child: Text(
                                      data[index].last_name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.0),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )),
                          color: Colors.white38,
                        ),*/
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "\  Last Name ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15.0, fontFamily: "Roboto",),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: Container(
                            height: 45,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].last_name,
                                // controller: lastnameController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                onChanged: (text) {
                                  print(text);

                                  lastname = text;
                                },
                              ),
                            ),
                          ),
                          color: Colors.white38,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "\  Email Id ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Roboto"),
                        ),
                        Card(
                          child: Container(
                            height: 45,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].email,
                                //controller: emailController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0, fontFamily: "Roboto"),
                                onChanged: (text) {
                                  email = text;
                                },
                              ),
                            ),
                          ),
                          color: Colors.white38,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "\  Mobile No ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Roboto"),
                        ),
                        Card(
                          child: Container(
                            height: 45,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextFormField(
                                autofocus: false,
                                initialValue: data[index].mobile,
                                //controller: emailController,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                onChanged: (text) {
                                  mobile = text;
                                },
                              ),
                            ),
                          ),
                          color: Colors.white38,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
