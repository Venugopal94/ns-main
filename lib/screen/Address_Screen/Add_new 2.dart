import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:robustremedy/screen/Address_Screen/address_screen.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:robustremedy/screen/auth/registration.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bouncing_widget/bouncing_widget.dart';

List data = [];
String selectedvalue;

final String url1 =
    'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=zonearea';

class Add_NewScreen extends StatefulWidget {
  final total;
  Add_NewScreen({Key key, @required this.total}) : super(key: key);

  @override
  _Add_NewScreenState createState() => _Add_NewScreenState();
}

class _Add_NewScreenState extends State<Add_NewScreen> {
  @override
  void initState() {
    fetchData();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Boolean variable for CircularProgressIndicator.
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id = prefs.getString('id');
    return user_id;
  }

  bool visible = false;
  // Getting value from TextField widget.
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();
  final buildingController = TextEditingController();
  final zoneController = TextEditingController();
  final streetController = TextEditingController();

  Future New_Address() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });
    dynamic token = await getStringValues();
    // Getting value from Controller
    String firstname = fnameController.text;
    String lastname = lnameController.text;
    String buildingno = buildingController.text;
    String zone = selectedvalue;
    String street = streetController.text;

    if (firstname.length == 0 ||
        lastname.length == 0 ||
        buildingno.length == 0 ||
        zone.length == 0 ||
        street.length == 0) {
      showInSnackBar("Field Should not be empty");
    } else {
      // SERVER API URL
      var url =
          'https://onlinefamilypharmacy.com/mobileapplication/address_new.php';

      // Store all data with Param Name.
      var data = {
        'firstname': firstname,
        'lastname': lastname,
        'buildingno': buildingno,
        'zone': zone,
        'street': street,
        'user_id': token
      };

      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);
      print(message);
      // If Web call Success than Hide the CircularProgressIndicator.
      if (response.statusCode == 200) {
        setState(() {
          visible = false;
        });
      }
      showInSnackBar(message);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Address_screen(total: widget.total)));
      // Showing Alert Dialog with Response JSON Message.
      /* showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );*/
    }
  }

  Future<String> fetchData() async {
    var response = await http.post(url1);

    if (response.statusCode == 200) {
      var res = await http.post(Uri.encodeFull(url1));

      var resBody = json.decode(res.body);
      print("___________JSJSJS");
      print(resBody);

      setState(() {
        data = resBody;
      });

      print('Loaded Successfully');

      return "Loaded Successfully";
    } else {
      throw Exception('Failed to load data.');
    }
  }

  Widget _emailPasswordWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Container(
            child: Text(
              "First Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          SizedBox(
            width: 120,
          ),
          Text(
            "Last Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Container(
            width: 175.0,
            child: TextField(
              controller: fnameController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 180.0,
            child: TextField(
              controller: lnameController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          )
        ]),
        SizedBox(
          height: 10,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /*SizedBox(
            width: 10,
          ),*/
              Text(
                "Building No",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                  // width: 44,
                  ),
              SizedBox(
                  //  width: 60,
                  ),
              Text(
                "Street",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100.0,
                child: TextField(
                  controller: buildingController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: Color(0xfff3f3f4),
                ),

                // child: DropdownButton(
                //
                //   value: selectedvalue,
                //   hint: Text("Select area",),
                //   items: data.map(
                //         (list) {
                //
                //       return DropdownMenuItem(
                //           child: SizedBox(
                //             width: 100.0,
                //             child: Text(list['zone']+"-"+ list['area']),
                //           ),
                //
                //           value: list['id']);
                //     },
                //   ).toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       selectedvalue = value;
                //       print(
                //           "-----------------------------------------SELECTED");
                //       print(selectedvalue);
                //
                //     });
                //   },
                // ),
                child: TypeAheadField<ZoneArea>(
                  textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      controller: this._typeAheadController),
                  hideOnLoading: true,
                  hideOnEmpty: true,
                  suggestionsCallback: UserApi.getUsersuggestion,
                  itemBuilder: (context, ZoneArea suggestion) {
                    final user = suggestion;
                    return ListTile(
                      title: Text(user.zone + "-" + user.area),
                    );
                  },
                  onSuggestionSelected: (ZoneArea suggestion) {
                    final user = suggestion;
                    _typeAheadController.text = user.area;
                    selectedvalue = user.id;
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                  width: 100.0,
                  child: TextField(
                    controller: streetController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true),
                  ))
            ]),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Add New Address")),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Image.asset(
                    //   "assets/map.jpeg",
                    //   height: 400,
                    // ),
                    SizedBox(
                      height: 50,
                    ),
                    // _emailPasswordWidget(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: width / 2.3,
                            child: Text(
                              "First Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            width: width / 38,
                          ),
                          Container(
                            width: width / 2.3,
                            child: Text(
                              "Last Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: width / 2.3,
                            child: TextField(
                              controller: fnameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true),
                            ),
                          ),
                          SizedBox(
                            width: width / 38,
                          ),
                          Container(
                            width: width / 2.3,
                            child: TextField(
                              controller: lnameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true),
                            ),
                          )
                        ]),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          /*SizedBox(
            width: 10,
          ),*/
                          Container(
                            width: width / 3.6,
                            child: Text(
                              "Building No",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            width: width / 38,
                          ),
                          Container(
                            width: width / 3.6,
                            child: Text(
                              "Zone/Area",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            width: width / 38,
                          ),
                          Container(
                            width: width / 3.6,
                            child: Text(
                              "Street",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: width / 3.6,
                            child: TextField(
                              controller: buildingController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true),
                            ),
                          ),
                          SizedBox(
                            width: width / 38,
                          ),
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xfff3f3f4),
                            ),

                            ///todo:
                            child: TypeAheadField<ZoneArea>(
                              textFieldConfiguration: TextFieldConfiguration(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                  controller: this._typeAheadController),
                              hideOnLoading: true,
                              hideOnEmpty: true,
                              suggestionsCallback: UserApi.getUsersuggestion,
                              itemBuilder: (context, ZoneArea suggestion) {
                                final user = suggestion;
                                return ListTile(
                                  title: Text(user.zone + "-" + user.area),
                                );
                              },
                              onSuggestionSelected: (ZoneArea suggestion) {
                                final user = suggestion;
                                _typeAheadController.text = user.area;
                                selectedvalue = user.id;
                              },
                            ),
                            // child: DropdownButton(
                            //
                            //   value: selectedvalue,
                            //   hint: Text("Select area",),
                            //   items: data.map(
                            //         (list) {
                            //
                            //       return DropdownMenuItem(
                            //           child: SizedBox(
                            //             width: 100.0,
                            //             child: Text(list['zone']+"-"+ list['area']),
                            //           ),
                            //
                            //           value: list['id']);
                            //     },
                            //   ).toList(),
                            //   onChanged: (value) {
                            //     setState(() {
                            //       selectedvalue = value;
                            //       print(
                            //           "-----------------------------------------SELECTED");
                            //       print(selectedvalue);
                            //
                            //     });
                            //   },
                            // ),
                          ),
                          SizedBox(
                            width: width / 38,
                          ),
                          Container(
                              width: width / 3.8,
                              child: TextField(
                                controller: streetController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true),
                              ))
                        ]),
                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Button(
                        onClick: New_Address,
                        btnText: "Add",
                      ),
                    ),
                    // SizedBox(height: height * .14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.midnightBlue,
    ));
  }

  showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}

class Button extends StatelessWidget {
  var btnText = "";
  var onClick;

  Button({this.btnText, this.onClick});
  Color yellowColors = Colors.yellow[700];
  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99, 1);
  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
        duration: Duration(milliseconds: 100),
        scaleFactor: 1.5,
        onPressed: onClick,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [yellowColors, Color(0xfffbb448)])),
          child: InkWell(
            child: Text(
              'Add',
              style: TextStyle(
                  fontSize: 20,
                  color: midnightBlue,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
