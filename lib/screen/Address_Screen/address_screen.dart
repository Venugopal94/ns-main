import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Address_Screen/Add_new.dart';
import 'package:robustremedy/screen/Address_Screen/edit_address.dart';
import 'package:robustremedy/screen/Address_Screen/order_summary_screen.dart';
import 'package:robustremedy/screen/Address_Screen/range_slider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:robustremedy/themes/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
String? addscreen;
class add_data {
  final String? first_name;
  final String? title;
  final String? last_name;
  final String? building;
  final String? addressid;
  final String? street;
  final String? zone;
  final String? area;
  final String? country;
  final String? select_address;
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
class Address_screen extends StatefulWidget {
  double total;

  Address_screen({Key? key, required this.total}) : super(key: key);
  @override
  _Address_screenState createState() => _Address_screenState();
}

class _Address_screenState extends State<Address_screen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool? selectadd;
  List<bool> _isChecks =[];
//dynamic checkid;
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String? user_id=prefs.getString('id');
    return user_id;
  }

  Future<List<add_data>> _fetch_add_data() async {
    String token = await getStringValues();
    var data = {'user_id': token};
    

    var url = 'https://onlinefamilypharmacy.com/mobileapplication/address_api.php';
    var response = await http.post(Uri.parse( url), body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new add_data.fromJson(item)).toList();
  }
  @override
  void initState() {
    super.initState();
    _fetch_add_data();
  addscreen='false';

  }
  
  Future removeadd(id) async {
     print(id);
    var url = 'https://onlinefamilypharmacy.com/mobileapplication/remove/remove_address.php';
    var data = {'id': id};
    var response = await http.post(Uri.parse( url), body: json.encode(data));
    var message = jsonDecode(response.body);
    setState(() {
      _fetch_add_data();
    });
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
        
        return Padding(
            padding: EdgeInsets.all(5.0),
            child: InkWell(
              onTap: (){
if(widget.total==null){
  showInSnackBar('Your Cart is empty');
}
else {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>
        PaymentScreen(addid: data[index], total: widget.total.round(),actutalTotal: widget.total,)),
  );
}
              },
           child: Card(
              
              child: Row(
                children: <Widget>[
                  
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  Edit_Address_Screen(addid: data[index],total:widget.total,addscreen:addscreen)),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                          Icons.edit,

                                        ),
                                      )),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: InkResponse(
                                      onTap: () {
                                      removeadd(data[index].addressid);
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
                                  fontSize: 14, fontWeight: FontWeight.bold,),
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
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Select Address"),
        backgroundColor: LightColor.yellowColor,
        foregroundColor: LightColor.midnightBlue,
      ),
      body:  Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
      Expanded(
      child: FutureBuilder<List<add_data>>(
      future: _fetch_add_data(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<add_data> data = snapshot.data ?? [];
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
          Container(
            height: 50,

            child:    ButtonTheme(
                minWidth: width,
                height: 50.0,
                child:
                ElevatedButton(onPressed:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Add_NewScreen(total: widget.total)));
                },
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: LightColor.yellowColor),

                  child: Text("Add Address",
                      style: TextStyle(
                          color: LightColor.midnightBlue,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
            ),
          ),

      ]),

    );
  }
  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(value),backgroundColor:LightColor.midnightBlue ,));
  }
}


