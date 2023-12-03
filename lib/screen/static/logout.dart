import 'package:robustremedy/screen/auth/login.dart';
import 'package:robustremedy/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class logout extends StatefulWidget {
  logout({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _logoutState createState() => _logoutState();
}

class _logoutState extends State<logout> { // Wrapper Widget
  String? email;

  Future userLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("email");
    await preferences.clear();
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showAlert(context));
    return Container(
    );
  }

  Future<void> showAlert(BuildContext context) async {
    await userLogout();
    // Create button
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen())
    );


  }

}