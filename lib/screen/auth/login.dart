import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:robustremedy/screen/auth/forgetpassword.dart';
import 'package:robustremedy/screen/auth/registration.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/bezierContainer.dart';
import 'package:robustremedy/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:showcaseview/showcase_widget.dart';
import 'package:showcaseview/showcaseview.dart';

//void main() async{
// checkLogin();
//WidgetsFlutterBinding.ensureInitialized();
//SharedPreferences preferences= await SharedPreferences.getInstance();
//var email =preferences.getString("email");
//await FlutterSession().set("token", email);
//runApp(MaterialApp(home: email== null?  LoginScreen() : HomeScreen(),));
//}

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, this.title}) : super(key: key);

  String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email=emailController.text;
    String id=user_id;
    prefs.setString('email', email,);
   // prefs.setString('userid', id,);
  //  print(user_id);
  }
  addStringTo(user_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String id=user_id;
   // prefs.setString('email', email,);
    prefs.setString('id', id,);
    //  print(user_id);
  }
  addStringTocart(cart_total) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int total= cart_total;
    // prefs.setString('email', email,);
    prefs.setInt('cart_total', total);
    //  print(user_id);
  }
 // AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

  }

  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email =prefs.getString("email");
    // bool _seen = (prefs.getBool('seen') ?? false);
    if(email == null)
    {

      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginScreen()));
    }
    else {
      // prefs.setBool('seen', true);

      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new HomeScreen()));
    }

  }

  @override
  // For CircularProgressIndicator.
  bool visible = false;
  var user_id,cart_total;
  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString("email", emailController.text);
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String email = emailController.text;
    String password = passwordController.text;
    if (
    email.length == 0 ||
        password.length == 0) {
      showInSnackBar("Field Should not be empty");

    }
    else {
      // SERVER LOGIN API URL
      var url = 'https://onlinefamilypharmacy.com/mobileapplication/login.php';
      // Store all data with Param Name.
      var data = {'email': email, 'password': password};

      // Starting Web API Call.
      var response = await http.post(Uri.parse( url), body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);
      var url1 = 'https://onlinefamilypharmacy.com/mobileapplication/getuserid.php';
      // Store all data with Param Name.
      var data1 = {'email': email};

      // Starting Web API Call.
      var response1 = await http.post(Uri.parse( url1), body: json.encode(data1));
      setState(() {
        user_id = jsonDecode(response1.body);
        
        addStringTo(user_id);
      });
      var url2 = 'https://onlinefamilypharmacy.com/mobileapplication/getcart_count.php';
      // Store all data with Param Name.
      var data2 = {'userid': user_id};

      // Starting Web API Call.
      var response2 = await http.post(Uri.parse( url2), body: json.encode(data2));
      setState(() {
        cart_total = jsonDecode(response2.body);
        
        addStringTocart(cart_total);
      });
      // If the Response Message is Matched.
      if (message == 'Login Matched') {
        // Hiding the CircularProgressIndicator.
        setState(() {
          visible = false;
        });
        // print(user_id);
        // Navigate to Profile Screen & Sending Email to Next Screen.
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context, animation, animationTime, child) {
                  return ScaleTransition(
                    alignment: Alignment.center,
                    child: child,
                    scale: animation,
                  );
                },
                pageBuilder: (context, animation, animationTime) {
                  return HomeScreen();
                })
          // MaterialPageRoute(builder: (context) => HomeScreen())
        );
      } else {
        // If Email or Password did not Matched.
        // Hiding the CircularProgressIndicator.
        setState(() {
          visible = false;
        });
        showInSnackBar(message);
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
  }


  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or', style: TextStyle(fontFamily: "Roboto")),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }



  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context,animation,animationTime,child){
                  return FadeTransition(
                    opacity:animation,
                    child: child,
                  );
                },
                pageBuilder: (context,animation,animationTime){
                  return RegistrationScreen();
                }));
            //MaterialPageRoute(builder: (context) => RegistrationScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(5),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, fontFamily: "Roboto"),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600, fontFamily: "Roboto"),
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

  Widget _emailPasswordWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Text(
          "Email Id",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: "Roboto"),
        ),
        TextField(
          controller: emailController,
          style: TextStyle(fontFamily: "Roboto"),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(

              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true
          ),),
        SizedBox(
          height: 10,
        ),
        Text(
          "Password",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: "Roboto"),
        ),
        TextField(
            style: TextStyle(fontFamily: "Roboto"),
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],

    );
  }
  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99,1);

  Color yellowColors = Colors.yellow[700] ?? Color.fromRGBO(1, 4, 99,1);
  Color blue=ButtonWid.midnightBlue;
  @override
  Widget build(BuildContext context) {
   /* WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context)
            .startShowCase([_one, _two,]));*/
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
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
                      SizedBox(height: 50),
                      _emailPasswordWidget(),
                      SizedBox(height: 20),
                /*  Showcase(
                    key: _one,
                    description: 'Tap to login',
                    child:*/
                /*  BouncingWidget(
                    duration: Duration(milliseconds: 100),
                    scaleFactor: 1.5,
                    onPressed: () {
                     // print("onPressed");
                    },
                    child:*/
                    Center(
                  child:
                      BouncingWidget(

                        onPressed: () {
                          userLogin();
                          print('hueu');
                        },
                          duration: Duration(milliseconds: 100),
                          scaleFactor: 1.5,
                          child: Container(
                          width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50),),
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
                              colors: [yellowColors,yellowColors])),
                      child: InkWell(
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20, color:blue,fontWeight: FontWeight.bold, fontFamily: "Roboto"),
                        ),


                      ),
                    )
                      ),
              /*   child: ButtonWid(
                        onClick: userLogin,

                         btnText: "Login",
                     ),*/

                      ),
                 // ),
                //  ),
                 InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration: Duration(milliseconds: 500),
                                  transitionsBuilder: (context,animation,animationTime,child){
                                    return SlideTransition(
                                      position: Tween(
                                          begin: Offset(1.0, 0.0),
                                          end: Offset(0.0, 0.0))
                                          .animate(animation),
                                      child: child,
                                    );
                                  },
                                  pageBuilder: (context,animation,animationTime){
                                    return forgetpwd();
                                  })
                            //
                          );
                        },
                        child:   Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password ?',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500, fontFamily: "Roboto")),
                        ),
                      ),


                      SizedBox(height:5),
                      _createAccountLabel(),

                 /* Showcase(
                    key: _two,
                    title: 'Skip',
                    description: 'Tap to Skip Login',
                    child:*/
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration: Duration(milliseconds: 800),
                                  transitionsBuilder: (context, animation, animationTime, child) {
                                    return ScaleTransition(
                                      alignment: Alignment.center,
                                      child: child,
                                      scale: animation,
                                    );
                                  },
                                  pageBuilder: (context, animation, animationTime) {
                                    return HomeScreen();
                                  })
                            // MaterialPageRoute(builder: (context) => HomeScreen())
                          );
                         /* Navigator.push(
                              context, MaterialPageRoute(builder: (context) => HomeScreen())); */
                        },
                        child:   Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: Text('Skip',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold,color: LightColor.midnightBlue, fontFamily: "Roboto")),
                        ),
                      )
                //),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
  }
  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(value,  style: TextStyle(fontFamily: "Roboto")),backgroundColor:LightColor.midnightBlue ,));
  }
}

class ButtonWid extends StatelessWidget {
  var btnText ="";
  var onClick;


  ButtonWid({required this.btnText, this.onClick});
  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99,1);

  Color yellowColors = Colors.yellow[700] ?? Color.fromRGBO(1, 4, 99,1);
  Color blue=ButtonWid.midnightBlue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onClick,



        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,

          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50),),
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
                  colors: [yellowColors,yellowColors])),
          child: InkWell(
            child: Text(
              'Login',
              style: TextStyle(fontSize: 20, color:blue,fontWeight: FontWeight.bold, fontFamily: "Roboto"),
            ),


          ),
        )

    );
  }

}



