import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Address_Screen/Add_new.dart';
import 'package:robustremedy/screen/Address_Screen/order_summary_screen.dart';
import 'package:robustremedy/screen/prescription/prescription_order_summary.dart';
import 'dart:io';
import 'dart:convert';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class add_data {
  final String first_name;
  final String title;
  final String last_name;
  final String building;
  final String addressid;
  final String street;
  final String zone;
  final String area;
  final String country;
  final String select_address;
  // final String email;
  add_data(
      {this.first_name,
        this.title,
        this.last_name,
        this.building,
        this.zone,
        this.area,
        this.country,
        this.addressid,
        this.street,
        this.select_address});
//List data;
  factory add_data.fromJson(Map<String, dynamic> json) {
    return add_data(
        addressid: json['addressid'],
        first_name: json['first_name'],
        title: json['title'],
        last_name: json['last_name'],
        building: json['building'],
        street: json['street'],
        zone: json['zone'],
        area: json['area'],
        country: json['country'],
        select_address: json['select_address']);
  }
}
class Prescription_Address_screen extends StatefulWidget {
  final pre_id;
  Prescription_Address_screen({Key key, @required this.pre_id}) : super(key: key);
  @override
  _Prescription_Address_screenState createState() => _Prescription_Address_screenState();
}

class _Prescription_Address_screenState extends State<Prescription_Address_screen> {
  bool selectadd;
  List<bool> _isChecks = List();
//dynamic checkid;
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id=prefs.getString('id');
    return user_id;
  }
  Future<List<add_data>> _fetch_add_data() async {
    dynamic token = await getStringValues();
    var data = {'user_id': token};
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/address_api.php';
    var response = await http.post(url, body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new add_data.fromJson(item)).toList();
  }

  imageSlider(context, data) {
    return  ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        for(int i=0;i<data.length;i++){

          _isChecks.add(false);
        }
        return



          Padding(
              padding: EdgeInsets.all(5.0),
              child: InkWell(
                onTap: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Prescription_Summary_Screen(addid: data[index].addressid,preid:widget.pre_id)),
                  );

                },
                child: Card(
                  // height: 150.0,
                  child: Row(
                    children: <Widget>[
                      /* Checkbox(
                      value: _isChecks[index],
                      onChanged: (bool val) {

                        // addcheckbox(data[index].id,val,data[index].title);
                        setState(() {
                          _isChecks[index] = val;
                        });
                       if(val==true){
                          setState(() {
                            checkid=data[index].id;
                          });
                        }
                      }),*/
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.home,
                                      color: LightColor.yellowColor,
                                    ),
                                    Expanded(
                                      child: Text(
                                        data[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: InkResponse(
                                          onTap: () {
                                            //  removeadd(data[index].id);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0),
                                            child: Icon(
                                              Icons.delete,
                                              color: LightColor.midnightBlue,
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(children: <Widget>[
                                  Text(
                                    "\Bldg No - ${data[index].building},",
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\  Street No - ${data[index].street},",
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\  Area  -${data[index].area}",
                                    style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold,),   overflow: TextOverflow.ellipsis,
                                  ),
                                ]),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  data[index].country,
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),)
          );
      },

    );
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Select Prescription Address")),
      body: Column(children: <Widget>[
        SizedBox(height: 25),
        Center(
          child: Container(
            height: 50,
            width: 200,
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
                    colors: [LightColor.yellowColor, Color(0xfffbb448)])),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Add_NewScreen()));
              },
              child: Text(
                'Add Address',
                style: TextStyle(
                    fontSize: 18,
                    color: LightColor.midnightBlue,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Container(height: height/1.5, child: FutureBuilder<List<add_data>>(
          future: _fetch_add_data(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<add_data> data = snapshot.data;
              return imageSlider(context, data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
                ));
          },
        ),),
      ]),

    );
  }
}


class Address_data extends StatefulWidget {
  // List data;
  @override
  _Address_dataState createState() => _Address_dataState();
}

class _Address_dataState extends State<Address_data> {
  var addselect;
  var add;

  bool _isCheck = false;
  List<bool> _isChecks = List();
  int selectedRadioTile,selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id=prefs.getString('id');
    return user_id;
  }

  getselectadd(add) {
    return add;
  }

  var selectadd = false;


//var id=_onRememberMeChanged(id);
  Future removeadd(id) async {
    // print(id);
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/remove/remove_address.php';
    var data = {'id': id};
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);
    setState(() {
      _fetch_add_data();
    });
  }
  var bill,ship;
  Future addcheckbox(idd,val,title) async {
    if(title=='BILLING'){

      print(val);
      var data = {'id': idd, 'value':val,'title':title};
      var url = 'https://onlinefamilypharmacy.com/mobileapplication/selected_address.php';
      var response = await http.post(url, body:json.encode(data));
    }
    else if (title=='SHIPPING'){
      print(val);
      var data = {'id': idd, 'value':val,'title':title};
      var url = 'https://onlinefamilypharmacy.com/mobileapplication/selected_address.php';
      var response = await http.post(url, body:json.encode(data));
    }
    else{

    }


  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<add_data>>(
      future: _fetch_add_data(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<add_data> data = snapshot.data;
          return imageSlider(context, data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
            ));
      },
    );
  }

  Future<List<add_data>> _fetch_add_data() async {
    dynamic token = await getStringValues();
    var data = {'user_id': token};
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/address_api.php';
    var response = await http.post(url, body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new add_data.fromJson(item)).toList();
  }

  imageSlider(context, data) {
    return  ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        for(int i=0;i<1;i++){

          _isChecks.add(false);
        }
        return



          Padding(
            padding: EdgeInsets.all(5.0),
            child: Card(
              // height: 150.0,
              child: Row(
                children: <Widget>[
                  Checkbox(
                      value: _isChecks[index],
                      onChanged: (bool val) {

                        // addcheckbox(data[index].id,val,data[index].title);
                        setState(() {
                          _isChecks[index] = val;
                        });
                        if(val==true){
                          setState(() {
                            // checkid=data[index];
                          });
                        }
                      }),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  color: LightColor.yellowColor,
                                ),
                                Expanded(
                                  child: Text(
                                    data[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: InkResponse(
                                      onTap: () {
                                        removeadd(data[index].id);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                          Icons.delete,
                                          color: LightColor.midnightBlue,
                                        ),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(children: <Widget>[
                              Text(
                                "\Bldg No - ${data[index].building},",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\  Street No - ${data[index].street},",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\  Area  -${data[index].area}",
                                style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold,),   overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              data[index].country,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
      },

    );
  }
}
