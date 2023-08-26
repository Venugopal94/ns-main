import 'package:flutter/material.dart';
import 'package:robustremedy/screen/Address_Screen/address_screen.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:robustremedy/screen/home/cart.dart';
import 'package:robustremedy/screen/profile/address_profile.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
class Edit_Address_Screen extends StatefulWidget {

  final addid,total,addscreen;
  Edit_Address_Screen({Key? key, @required this.addid,@required this.total,@required this.addscreen})
      : super(key: key);
  @override
  _Edit_Address_ScreenState createState() => _Edit_Address_ScreenState();
}

class _Edit_Address_ScreenState extends State<Edit_Address_Screen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Boolean variable for CircularProgressIndicator.
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String? user_id=prefs.getString('id');
    return user_id;
  }
  bool visible = false;
  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99, 1);
  String? firstname;
  String? lastname;
  String? buildingno;
  String? zone;
  String? street;


  Future edit_Address() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });
    dynamic token = await getStringValues();
    // Getting value from Controller


    if (firstname?.length == 0 ||
        lastname?.length == 0 ||
        buildingno?.length == 0 ||
        zone?.length == 0 ||
        street?.length == 0 ) {
      showInSnackBar("Field Should not be empty");

    } else {
      // SERVER API URL
      var url = 'https://onlinefamilypharmacy.com/mobileapplication/edit_address.php';

      // Store all data with Param Name.
      var data = {
        'firstname': firstname,
        'lastname': lastname,
        'buildingno': buildingno,
        'zone': zone,
        'street': street,
        'add_id':widget.addid.addressid
      };

      // Starting Web API Call.
      var response = await http.post(Uri.parse( url), body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);

      // If Web call Success than Hide the CircularProgressIndicator.
      if (response.statusCode == 200) {
        setState(() {
          visible = false;
        });
      }
      showInSnackBar(message);
      if(widget.addscreen=='false') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      }
      else{
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Address_profile()));
      }

    }
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    firstname=widget.addid.first_name;
    lastname=widget.addid.last_name;
    buildingno=widget.addid.building;
    zone=widget.addid.zone;
    street=widget.addid.street;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text("Edit Address"),
        backgroundColor: LightColor.yellowColor,
      ),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                  Container(
                      width: width/2.3,
                      child: Text(
                        "First Name",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),),
                  SizedBox(
                    width: width/38,
                  ),
                  Container(
                      width: width/2.3,
                      child:Text(
                        "Last Name",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                      Container(
                        width: width/2.3,
                        decoration: new BoxDecoration(color:  Color(0xfff3f3f4),),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            autofocus: false,
                            initialValue: widget.addid.first_name,
                            //controller: emailController,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0),
                            onChanged: (text) {
                              firstname=text;



                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width/38,
                      ),
                      Container(
                        width:width/2.3, decoration: new BoxDecoration(color:  Color(0xfff3f3f4),),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            autofocus: false,
                            initialValue: widget.addid.last_name,
                            //controller: emailController,

                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0),
                            onChanged: (text) {
                              lastname=text;
                            },
                          ),
                        ),
                      )
                    ]),
                    SizedBox(
                      height: 10,
                    ),Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                    Text(
                      "Building No",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                    Container(
                      width: width/1.15, decoration: new BoxDecoration(color: Color(0xfff3f3f4)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          autofocus: false,
                          initialValue: widget.addid.building,
                          //controller: emailController,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                          onChanged: (text) {
                            buildingno=text;
                          },
                        ),
                      ),
                    ),]),
                    SizedBox(
                      height: 10,
                    ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                    Text(
                      "Zone/Area",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                    Container(
                      width: width/1.15, decoration: new BoxDecoration(color: Color(0xfff3f3f4)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          autofocus: false,
                          initialValue: widget.addid.zone,
                          //controller: emailController,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                          onChanged: (text) {
                            zone=text;
                          },
                        ),
                      ),
                    ),]),
                    SizedBox(
                      height: 10,
                    ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                    Text(
                      "Street",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ), ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                  Container(
                      width: width/1.15, decoration: new BoxDecoration(color: Color(0xfff3f3f4)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          autofocus: false,
                          initialValue: widget.addid.street,
                          //controller: emailController,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                          onChanged: (text) {
                            street=text;
                          },
                        ),
                      ),),]),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      /*SizedBox(
            width: 10,
          ),*/

                      SizedBox(
                        // width: 44,
                      ),

                      SizedBox(
                        //  width: 60,
                      ),

                    ]),

                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Button(
                        onClick: edit_Address,
                        btnText: "Update",
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
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(value),backgroundColor:LightColor.midnightBlue ,));
  }
  showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }
}

class Button extends StatelessWidget {
  var btnText = "";
  var onClick;

  Button({required this.btnText, this.onClick});
  Color yellowColors = Colors.yellow[700] ?? Color(0);
  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99, 1);
  @override
  Widget build(BuildContext context) {
    return  BouncingWidget(
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
              'Update',
              style: TextStyle(
                  fontSize: 20,
                  color: midnightBlue,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
