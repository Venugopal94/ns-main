import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:geocoding/geocoding.dart';
//import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:robustremedy/screen/auth/login.dart';
import 'package:robustremedy/screen/auth/usermodel.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/bezierContainer.dart';
import 'package:geolocator/geolocator.dart';

List<dynamic> data = [];
String? selectedvalue;
final String url1 =
    'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=zonearea';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key, this.title}) : super(key: key);

  String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<RegistrationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // Boolean variable for CircularProgressIndicator.
  bool visible = false;
  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99, 1);
  // Getting value from TextField widget.
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final buildingController = TextEditingController();
  final zoneController = TextEditingController();
  final streetController = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchData();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = DarwinInitializationSettings();
    var initialise = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(initialise,
        onDidReceiveNotificationResponse: onSelectionNotification);
    //checkLogin();
  }

  Future onSelectionNotification(NotificationResponse details) async {
    if (details?.payload != null) {
      debugPrint("Notification :" + details.payload!);
    }
  }

  // Future<String> fetchData() async {
  //   var response = await http.post(url1);
  //
  //   if (response.statusCode == 200) {
  //     var res = await http
  //         .post(Uri.encodeFull(url1));
  //
  //     var resBody = json.decode(res.body);
  //
  //
  //     setState(() {
  //       data = resBody;
  //     });
  //
  //
  //
  //     return "Loaded Successfully";
  //   } else {
  //     throw Exception('Failed to load data.');
  //   }
  // }

  Future showNotification() async {
    var android = AndroidNotificationDetails(
        'channelId', 'Online Family Pharmacy');
    var ios = DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.show(
        0,
        'Thank you for your Registration',
        'Shop online on Qatars Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.',
        platform,
        payload: 'some details');
  }

  _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    var addresses =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    var first = addresses.first;
    print("${first.name}");
  }

  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String firstname = fnameController.text;
    String lastname = lnameController.text;
    String mobileno = mobileController.text;
    String email = emailController.text;
    String buildingno = buildingController.text;
    String zone = selectedvalue ?? "";
    String street = streetController.text;
    String password = passwordController.text;
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (mobileno.length != 8) {
      showInSnackBar("Invalid Mobile No");
    } else if (firstname.length == 0 ||
        lastname.length == 0 ||
        buildingno.length == 0 ||
        zone.length == 0 ||
        street.length == 0 ||
        password.length == 0 ||
        confirmPasswordController.text.length == 0) {
      showInSnackBar("Field Should not be empty");
    } else if (!regex.hasMatch(email)) {
      showInSnackBar("Enter Valid Email");
    } else if (passwordController.text != confirmPasswordController.text) {
      showInSnackBar('Password Does not match');
    } else {
      // SERVER API URL
      var url =
          'https://onlinefamilypharmacy.com/mobileapplication/register.php';

      // Store all data with Param Name.
      var data = {
        'firstname': firstname,
        'lastname': lastname,
        'mobileno': mobileno,
        'email': email,
        'buildingno': buildingno,
        'zone': zone,
        'street': street,
        'password': password
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
      showNotification();
      fnameController.clear();
      lnameController.clear();
      mobileController.clear();
      emailController.clear();
      buildingController.clear();
      zoneController.clear();
      streetController.clear();
      passwordController.clear();
      showInSnackBar(
          "Verification link has been sent to your email. Please verify to complete registration!");
    }
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context, animation, animationTime, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                pageBuilder: (context, animation, animationTime) {
                  return LoginScreen();
                }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset('assets/Login/logo.png'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .1),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
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
                          Text(
                            "Mobile No",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: width / 5.5,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: '+974',
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true),
                            ),
                          ),
                          SizedBox(
                            width: width / 38,
                          ),
                          Container(
                            width: width / 1.45,
                            child: TextField(
                              controller: mobileController,
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
                          Text(
                            "Email Id",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ]),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: width / 1.2,
                            child: Text(
                              "Building No",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ]),
                    TextField(
                      controller: buildingController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: width / 1.2,
                            child: Text(
                              "Zone/Area",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 45,
                            width: width / 1.2,
                            color: Color(0xfff3f3f4),
                            child:
                            DropdownSearch<UserModel>(
                              popupProps: PopupProps.menu(
                                showSelectedItems: true,
                              ),
                              asyncItems: (String? filter) async {
                                var response = await Dio().get(
                                  "https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=zonearea",
                                  queryParameters: {"filter": filter},
                                );
                                var models =
                                UserModel.fromJsonList(response.data);
                                return models;
                              },
                              onChanged: (UserModel? data) {
                                print(data);
                                selectedvalue = data?.id ?? "";
                              },
                            )
                          ),
                        ]),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: width / 1.2,
                            child: Text(
                              "Street",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ]),

                    TextField(
                      controller: streetController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ]),
                    TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xfff3f3f4),
                            filled: true)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Confirm Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ]),

                    TextField(
                        obscureText: true,
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xfff3f3f4),
                            filled: true)),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Button(
                        onClick: userRegistration,
                        btnText: "Registration",
                      ),
                    ),
                    // SizedBox(height: height * .14),
                    _loginAccountLabel(),
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
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.midnightBlue,
    ));
  }
}

class UserApi {
  static Future<List<ZoneArea>> getUsersuggestion(String query) async {
    final response = await http.post(Uri.parse( url1));

    final List Zone = json.decode(response.body);
    return Zone.map((json) => ZoneArea.fromJson(json)).where((user) {
      final nameLower = user.area.toLowerCase();
      final queryLower = query.toLowerCase();

      return nameLower.contains(queryLower);
    }).toList();
  }
}

class ZoneArea {
  final String zone;
  final String area;
  final String? id;

  const ZoneArea({required this.zone, required this.area, this.id});
  static ZoneArea fromJson(Map<String, dynamic> json) =>
      ZoneArea(zone: json['zone'], area: json['area'], id: json['id']);
}

class Button extends StatelessWidget {
  var btnText = "";
  var onClick;

  Button({required this.btnText, this.onClick});
  Color yellowColors = Colors.yellow[700] ??  Color(0);
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
              'Register Now',
              style: TextStyle(
                  fontSize: 20,
                  color: midnightBlue,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
