import 'dart:async';
import 'dart:math';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:robustremedy/screen/auth/forgetpassword.dart';
import 'package:robustremedy/screen/auth/registration.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/PinCodeTextField.dart';
import 'package:robustremedy/widgets/bezierContainer.dart';
import 'package:robustremedy/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/sms_autofill.dart';

class VerifyOtpScreen extends StatefulWidget {
  VerifyOtpScreen({Key? key, this.title, required this.firstname, required this.lastname, required this.mobileno, required this.email, required this.buildingno, required this.password, required this.street, required this.zone})
      : super(key: key);

  String? title;
  String firstname;
  String lastname;
  String mobileno;
  String email;
  String buildingno;
  String zone;
  String street;
  String password;

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> with CodeAutoFill {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String? generatedOTP;
  Timer? timer;
  int start = 60;
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = DarwinInitializationSettings();
    var initialise = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(initialise,
        onDidReceiveNotificationResponse: onSelectionNotification);
    sendOTP();
    startTimer();
  }

  Future onSelectionNotification(NotificationResponse details) async {
    if (details?.payload != null) {
      debugPrint("Notification :" + details.payload!);
    }
  }

  @override
  // For CircularProgressIndicator.
  bool visible = false;
  var user_id, cart_total;
  final TextEditingController _otpController = TextEditingController();


  Future verifyOtp() async {
    // Getting value from Controller
    String otp = _otpController.text;
    if (otp == generatedOTP) {
        userRegistration();
      } else {
      showInSnackBar("Invalid OTP, Please enter valid OTP.");
    }
  }

  Future sendOTP() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });
      generatedOTP = generate4Digits();
      var url = 'https://messaging.ooredoo.qa/bms/soap/Messenger.asmx/HTTP_SendSms?customerID=2369&userName=Family&userPassword=pr5@g0277lRT&originator=Family Ph&smsText=Your Family Pharmacy OTP is: ${generatedOTP}.Don\'t share it with anyone.&recipientPhone=+974${widget.mobileno}&messageType=0&defDate=&blink=false&flash=false&Private=false';
      // Store all data with Param Name.

      // Starting Web API Call.
      var response = await http.get(Uri.parse(url));
       //var message = jsonDecode(response.body);
      setState(() {
      visible = true;
      });
      print(response);
    }

  String generate4Digits(){
    var rng = Random();
    String generatedNumber = '';
    for(int i=0;i<4;i++){
      generatedNumber += (rng.nextInt(9)+1).toString();
    }
    return generatedNumber;
  }
  Widget createAccountLabel() {
    return InkWell(
      onTap: () {
        if (start == 0) {
          sendOTP();
          startTimer();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(5),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Didn't Receive OTP?",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto"),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Resend',
              style: TextStyle(
                  color: start == 0 ? Color(0xfff79c4f) : Color(0xfff79c4f).withOpacity(0.5),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto"),
            ),
            SizedBox(width: 20,),
            if (start != 0)
              Text(
                '00:'+ (('${start}'.length == 2) ? '${start}' : '0${start}'),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Roboto"),
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

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    start = 60;
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  Color yellowColors = Colors.yellow[700] ?? Color.fromRGBO(1, 4, 99, 1);
  Color blue = ButtonWid.midnightBlue;

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: null,
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),

                      _title(),

                      Text(
                        "Verification Code",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto"),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Please type the verification code \nsent to +974 ****${widget.mobileno.substring(widget.mobileno.length - 4)}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Roboto"),
                      ),
                      SizedBox(height: 30),
                      PinCodeTextField(
                          pinBoxHeight: 80,
                          pinBoxWidth: 50,
                          isCupertino: true,
                          autofocus: true,
                          controller: _otpController,
                          maxLength: 4,
                          hideCharacter: false,
                          pinBoxBorderWidth: 1,
                          pinBoxRadius: 8,
                          pinBoxColor: Colors.grey.shade300,
                          defaultBorderColor: Colors.transparent,
                          hasTextBorderColor: Color(0xfff3f3f4),
                          hasError: false ,
                          errorBorderColor: const Color(0xffC50000),
                          pinTextStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontSize: FontSize.large.value,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          )),
                      Container(
                        color: Colors.transparent,
                        child: PinFieldAutoFill(
                          decoration: UnderlineDecoration(
                              textStyle: const TextStyle(color: Colors.transparent),
                              colorBuilder: const FixedColorBuilder(Colors.transparent)),
                          // decoration: PinDecoration(),
                          onCodeChanged: _onCodeChanged,
                          codeLength: 4,
                          autoFocus: true,
                          controller: _otpController,
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: BouncingWidget(
                            onPressed: () {
                              verifyOtp();
                            },
                            duration: Duration(milliseconds: 100),
                            scaleFactor: 1.5,
                            child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              height: 50,
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
                                      colors: [yellowColors, yellowColors])),
                              child: InkWell(
                                child: Text(
                                  "Verify Now",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: blue,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Roboto"),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(height: 20),
                      createAccountLabel(),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });
      // SERVER API URL
      var url =
          'https://onlinefamilypharmacy.com/mobileapplication/updateregistereduserstatus.php';

      // Store all data with Param Name.
      var data = {
        'firstname': widget.firstname,
        'lastname': widget.lastname,
        'mobileno': widget.mobileno,
        'email': widget.email,
        'buildingno': widget.buildingno,
        'zone': widget.zone,
        'street': widget.street,
        'password': widget.password,
        'status': 1
      };

      // Starting Web API Call.
      var response = await http.post(Uri.parse( url), body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);

      // If Web call Success than Hide the CircularProgressIndicator.
      if (message['status'] == 200) {
        setState(() {
          visible = false;
        });
        userLogin(widget.email, widget.password);
      } else {
        showInSnackBar(message['message']);
      }
  }

  void showVerificationAlert() {
    showDialog(
        context: context,
        builder: (context)
        {
          Color yellowColors = Colors.yellow[700] ??  Color(0);

          return AlertDialog(
            title: Container(
                alignment: Alignment.center,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(23),
                    child: Container(
                      alignment: Alignment.center,
                      width: 46,
                      height: 46,
                      color: blue,
                      child: Icon(Icons.email_outlined, color: Colors.white,),
                    ))
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 4.8,
                    width: MediaQuery
                        .of(context)
                        .size
                        .height,
                    alignment: Alignment.center,
                    child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text('Verified!',
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text("You have successfully verified",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:<Widget>[
                              Text('Welcome to ',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                              Text(' Family',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                    color: yellowColors),
                                textAlign: TextAlign.center,
                              )
                            ],),

                          SizedBox(height: 20,),
                          Container(
                              height: 40,
                              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: BouncingWidget(
                                  onPressed: () {
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
                                              return HomeScreen();
                                            }));
                                  },
                                  duration: Duration(milliseconds: 100),
                                  scaleFactor: 1.5,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 200,
                                    height: 50,
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
                                            colors: [yellowColors, yellowColors])),
                                    child: InkWell(
                                      child: Text(
                                        "Done",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: blue,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Roboto"),
                                      ),
                                    ),
                                  )),),
                        ]
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

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

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(value, style: TextStyle(fontFamily: "Roboto")),
      backgroundColor: LightColor.midnightBlue,
    ));
  }

  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    SmsAutoFill().listenForCode;
    verifyOtp();
  }

  void _onCodeChanged(code) {
    if (code!.length == 4) {
      _otpController.text = code;
      listenOtp();
    }
  }

  addStringTo(user_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = user_id;
    prefs.setString(
      'id',
      id,
    );
  }

  Future userLogin(String email, String password) async {
    setState(() {
      visible = true;
    });

    if (email.length == 0 || password.length == 0) {
      showInSnackBar("Field Should not be empty");
    } else {
      // SERVER LOGIN API URL
      var url = 'https://onlinefamilypharmacy.com/mobileapplication/login.php';
      // Store all data with Param Name.
      var data = {'email': email, 'password': password};

      // Starting Web API Call.
      var response = await http.post(Uri.parse(url), body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);
      SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.remove("email");
        await preferences.clear();
      // If the Response Message is Matched.
      if (message == 'Login Matched') {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("email", email);
        // Hiding the CircularProgressIndicator.
        setState(() {
          visible = false;
        });
        showVerificationAlert();
      } else {
        // If Email or Password did not Matched.
        // Hiding the CircularProgressIndicator.
        setState(() {
          visible = false;
        });
        showInSnackBar(message);
      }
    }
  }

  @override
  void codeUpdated() {
    print("object");
  }
}



class ButtonWid extends StatelessWidget {
  var btnText = "";
  var onClick;

  ButtonWid({required this.btnText, this.onClick});

  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99, 1);

  Color yellowColors = Colors.yellow[700] ?? Color.fromRGBO(1, 4, 99, 1);
  Color blue = ButtonWid.midnightBlue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onClick,
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
                  colors: [yellowColors, yellowColors])),
          child: InkWell(
            child: Text(
              'Login',
              style: TextStyle(
                  fontSize: 20,
                  color: blue,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
            ),
          ),
        ));
  }
}
