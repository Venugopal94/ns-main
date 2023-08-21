import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:robustremedy/screen/static/advertise_screen.dart';
import 'package:robustremedy/screen/auth/login.dart';
import 'package:robustremedy/screen/auth/registration.dart';
import 'package:robustremedy/screen/profile/profile_page.dart';
import 'package:robustremedy/screen/static/About_Us.dart';
import 'package:robustremedy/screen/static/All_branch.dart';
import 'package:robustremedy/screen/static/Contact_Us.dart';
import 'package:robustremedy/screen/static/Delivery_Info.dart';
import 'package:robustremedy/screen/static/Privacy_Policy.dart';
import 'package:robustremedy/screen/static/Terms_Condition.dart';
import 'package:robustremedy/screen/Item_group_screen/Wishlist.dart';
import 'package:robustremedy/screen/static/logout.dart';
import 'package:robustremedy/screen/home_screen.dart';
import 'package:robustremedy/screen/static/Refund_Replacement.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/custom_divider_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer_without extends StatefulWidget {
  //final String email;
  @override
  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99, 1);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer_without> {
  var username;
//var userid;
  var id;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String useridValue = prefs.getString('userid') ?? "";
    print(useridValue);
    //return useridValue;
    setState(() {
      username = prefs.getString("email");
      id = prefs.getString('userid');
    });
  }

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String useridValue = prefs.getString('id') ?? "";
    print(useridValue);
    //return useridValue;
    setState(() {
      // username = prefs.getString("email");
      id = prefs.getString('id');
    });
  }

  @override
  void initState() {
    super.initState();
    getStringValuesSF();
    getStringValues();
  }

  Widget build(BuildContext context) {
    // TODO: implement build

    return Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              color: LightColor.yellowColor,

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('assets/Login/logo.png'),

                    ),
                  ),


                  SizedBox(height: 10.0,),
                ],
              ),
            ),


            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: new Image.asset("assets/Drawer/allcategories.png",
                  width: 20.0, color: AppDrawer_without.midnightBlue),
              title: Text('Home',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),

            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: new  Icon(Icons.login,
                  size: 25.0, color: AppDrawer_without.midnightBlue),
              title: Text('Login',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: new  Icon(Icons.login,
              size: 25.0, color: AppDrawer_without.midnightBlue),
              title: Text('Registration',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
              },
            ),




            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: new Image.asset("assets/Drawer/advertise.png",
                  width: 20.0, color: AppDrawer_without.midnightBlue),

              title: Text('Advertise',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Advertise_Screen()));
              },
            ),

            CustomDividerView(),
            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: new Image.asset("assets/Drawer/delivery.png",
                  width: 20.0, color: AppDrawer_without.midnightBlue),
              title: Text('Locate Us',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => All_branch()));
              },
            ),

            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: new Image.asset("assets/Drawer/aboutus.png",
                  width: 20.0, color: AppDrawer_without.midnightBlue),
              title: Text('About Us',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => About_Us_Screen()));
              },
            ),

            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: new Image.asset("assets/Drawer/contactus.png",
                  width: 20.0, color: AppDrawer_without.midnightBlue),
              title: Text('Contact Us',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Contact_Us()));
              },
            ),
            CustomDividerView(),
            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: new Image.asset("assets/Drawer/terms.png",
                  width: 20.0, color: AppDrawer_without.midnightBlue),
              title: Text('Terms & Condition',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TermsScreen()));
              },
            ),

            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: new Image.asset("assets/Drawer/privacy.png",
                  width: 20.0, color: AppDrawer_without.midnightBlue),
              title: Text('Privacy Policy',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PolicyScreen()));
              },
            ),

            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: new  Icon(Icons.note,
                  size: 25.0, color: AppDrawer_without.midnightBlue),
              title: Text('Delivery Information',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DeliveryInfoScreen()));
              },
            ),

            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: new  Icon(Icons.refresh_sharp,
                  size: 25.0, color: AppDrawer_without.midnightBlue),
              title: Text('Refund & Replacement',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RefundScreen()));
              },
            ),


          ],
        ));
  }
}
