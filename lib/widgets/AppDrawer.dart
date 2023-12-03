import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:robustremedy/screen/prescription/myprescriptions.dart';
import 'package:robustremedy/screen/static/advertise_screen.dart';
import 'package:robustremedy/screen/static/catlogue.dart';
import 'package:robustremedy/screen/static/certification.dart';
import 'package:robustremedy/screen/static/faq_screen.dart';
import 'package:robustremedy/screen/profile/myorders.dart';
import 'package:robustremedy/screen/profile/profile_page.dart';
import 'package:robustremedy/screen/static/About_Us.dart';
import 'package:robustremedy/screen/static/All_branch.dart';
import 'package:robustremedy/screen/static/Contact_Us.dart';
import 'package:robustremedy/screen/static/Delivery_Info.dart';
import 'package:robustremedy/screen/static/Privacy_Policy.dart';
import 'package:robustremedy/screen/static/Terms_Condition.dart';
import 'package:robustremedy/screen/Item_group_screen/Wishlist.dart';
import 'package:robustremedy/screen/static/insurance.dart';
import 'package:robustremedy/screen/static/logout.dart';
import 'package:robustremedy/screen/home_screen.dart';
import 'package:robustremedy/screen/static/Refund_Replacement.dart';
import 'package:robustremedy/screen/prescription/upload_prescription.dart';
import 'package:robustremedy/screen/static/loyaltyprogram.dart';
import 'package:robustremedy/screen/static/ministrycircular.dart';
import 'package:robustremedy/screen/static/photogallery.dart';
import 'package:robustremedy/screen/static/salesteam.dart';
import 'package:robustremedy/screen/static/warehouse.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/widgets/custom_divider_view.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatefulWidget {
  //final String email;
  @override
  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99, 1);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var username;

  final _url =
      'https://play.google.com/store/apps/details?id=com.familypharmacy.qatar';
  final String appStore =
      'https://apps.apple.com/app/family-pharmacy-qatar/id1643469093';
//var userid;
  void _launchURL() async => Platform.isIOS
      ? await canLaunch(appStore)
          ? await launch(appStore)
          : throw 'Could not launch $appStore'
      : await canLaunch(_url)
          ? await launch(_url)
          : throw 'Could not launch $_url';

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
    

    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: AppDrawer.midnightBlue),
          accountName: Text(
            '${username}',
            style:
                TextStyle(fontSize: 15.0, color: Colors.white.withOpacity(1.0), fontFamily: "Roboto"),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                ? new Color(0xFF0062ac)
                : Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProfile()));
              },
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
          ), accountEmail: null,
        ),
        //  DrawerHeader(

        //   child: Container(
        //     child: Text('${email}', style: TextStyle(color: Colors.white.withOpacity(1.0)),),
        //     alignment: Alignment.bottomLeft, // <-- ALIGNMENT
        //    height: 10,
        //    ),
        //  decoration: BoxDecoration(
        //       color: midnightBlue
        //   ),
        //   ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Image.asset("assets/Drawer/allcategories.png",
              width: 20.0, color: AppDrawer.midnightBlue),
          title: Text('Home',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Image.asset("assets/Drawer/wishlist.png",
              width: 20.0, color: AppDrawer.midnightBlue),
          title: Text('Your Wishlist',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => WishList()));
          },
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Image.asset("assets/Drawer/youraccount.png",
              width: 20.0, color: AppDrawer.midnightBlue),
          title: Text('Your Profile',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyProfile()));
          },
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Image.asset("assets/Drawer/orderhistory.png",
              width: 20.0, color: AppDrawer.midnightBlue),
          title: Text('Order History',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => myorder()));
          },
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Image.asset("assets/Drawer/advertise.png",
              width: 20.0, color: AppDrawer.midnightBlue),
          title: Text('Advertise',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Advertise_Screen()));
          },
        ),
//        ListTile(
//          trailing: Icon(Icons.keyboard_arrow_right),
//          leading: new Icon(Icons.directions_car,
//              size: 25.0, color: AppDrawer.midnightBlue),
//          title: Text('Track Your Orders',
//              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//          onTap: () {
//            Navigator.push(
//                context, MaterialPageRoute(builder: (context) => trackorder()));
//          },
//        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Icon(Icons.line_style,
              size: 25.0, color: AppDrawer.midnightBlue),
          title: Text('My Prescription',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => myprescription()));
          },
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Image.asset("assets/Drawer/rx.png",
              width: 20.0, color: AppDrawer.midnightBlue),
          title: Text('Upload Prescription',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Upload_prescription()));
          },
        ),
        CustomDividerView(),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Image.asset("assets/Drawer/aboutus.png",
              width: 20.0, color: AppDrawer.midnightBlue),
          title: Text('About Us',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => About_Us_Screen()));
          },
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Image.asset("assets/Drawer/contactus.png",
              width: 20.0, color: AppDrawer.midnightBlue),
          title: Text('Contact Us',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Contact_Us()));
          },
        ),
        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Image.asset("assets/Drawer/delivery.png",
              width: 20.0, color: AppDrawer.midnightBlue),
          title: Text('Locate Us',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => All_branch()));
          },
        ),

        CustomDividerView(),

        /*ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(Icons.supervised_user_circle,color:LightColor.midnightBlue),
          title: Text('Sales Team',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Salesteam()));
          },
        ),*/

        CustomDividerView(),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(Icons.info_outline, color: LightColor.midnightBlue),
          title: Text('Insurance',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Insurance_Screen()));
          },
        ),

        // ListTile(
        //   trailing: Icon(Icons.keyboard_arrow_right),
        //   leading: Icon(Icons.loyalty, color: LightColor.midnightBlue),
        //   title: Text('Loyalty Program',
        //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => Loyaltyprogram_Screen()));
        //   },
        // ),
//        ListTile(
//          trailing: Icon(Icons.keyboard_arrow_right),
//          leading: Icon(Icons.perm_device_information,color:LightColor.midnightBlue),
//          title: Text('Ministry Circular',
//              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//          onTap: () {
//            Navigator.push(
//                context, MaterialPageRoute(builder: (context) => ministrycircular_Screen()));
//          },
//        ),
        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(Icons.security, color: LightColor.midnightBlue),
          title: Text('Certification',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => certification_Screen()));
          },
        ),
        /* ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: Icon(Icons.calendar_view_day,color:LightColor.midnightBlue),
          title: Text('Catlogue',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Catlogue()));
          },
        ),
        */

        CustomDividerView(),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading:
              new Icon(Icons.star, size: 25.0, color: AppDrawer.midnightBlue),
          title: Text('Rate App',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            _launchURL();
          },
        ),
        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading:
              new Icon(Icons.share, size: 25.0, color: AppDrawer.midnightBlue),
          title: Text('Share App',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            final RenderBox? box = context.findRenderObject() as RenderBox;
            if (box != null) {
              Platform.isAndroid
                  ? Share.share(
                  '\n\n Shop online on Qatar’s Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.' +
                      '\n\n $_url',
                  sharePositionOrigin:
                  box!.localToGlobal(Offset.zero) & box!.size)
                  : Share.share(
                  '\n\n Shop online on Qatar’s Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.' +
                      '\n\n $appStore',
                  sharePositionOrigin:
                  box.localToGlobal(Offset.zero) & box.size);
            }
          },
        ),
        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Icon(Icons.message,
              size: 25.0, color: AppDrawer.midnightBlue),
          title: Text('FAQ',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => faq()));
          },
        ),
        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Image.asset("assets/Drawer/terms.png",
              width: 20.0, color: AppDrawer.midnightBlue),
          title: Text('Terms & Condition',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TermsScreen()));
          },
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Image.asset("assets/Drawer/privacy.png",
              width: 20.0, color: AppDrawer.midnightBlue),
          title: Text('Privacy Policy',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PolicyScreen()));
          },
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading:
              new Icon(Icons.note, size: 25.0, color: AppDrawer.midnightBlue),
          title: Text('Delivery Information',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DeliveryInfoScreen()));
          },
        ),

        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Icon(Icons.refresh_sharp,
              size: 25.0, color: AppDrawer.midnightBlue),
          title: Text('Refund & Replacement',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RefundScreen()));
          },
        ),
        CustomDividerView(),
        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          leading: new Image.asset("assets/Drawer/logout.png",
              width: 20.0, color: AppDrawer.midnightBlue),
          title: Text('Log Out',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Roboto")),
          onTap: () async {
            SharedPreferences pf = await SharedPreferences.getInstance();
            pf.clear();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => logout(title: '',)));
          },
        ),
      ],
    ));
  }
}
