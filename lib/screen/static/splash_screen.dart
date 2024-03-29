import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:robustremedy/screen/intro_screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Helpers/app_update_checker.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashStateScreen createState() => _SplashStateScreen();
}

class _SplashStateScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      checkForAppUpdate();
    });
  }

  checkForAppUpdate() async {
    AppUpdate appUpdateInfo = await AppUpdateChecker.instance.isAppNeedsUpdate();
    if (appUpdateInfo.shouldShowUpdateAlert) {
      _showVersionDialog(
          context,
          appUpdateInfo.isForceUpdateRequired,
          appUpdateInfo.updateVersion);
    } else {
      navigationPage();
    }
  }

  // It will show alert with single "Update" button if force update is true user has to go through update inorder use the App.
  // if it's false it allows the user to skip the update or can update.
  //'onSkipShouldGoHome' used decide where to take the user in case of user skip the update.
  _showVersionDialog(context, bool isForceUpdateOn,
      double newVersion) async {
    List<Widget> alertButtons = _buildButtonsForForceUpdateAlert(
        context,
        Platform.isIOS
            ? "https://apps.apple.com/us/app/family-pharmacy-qatar/id1643469093"
            : "https://play.google.com/store/apps/details?id=com.familypharmacy.qatar&hl=en&gl=US",
        isForceUpdateOn,
        newVersion);
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message = "There is a newer version of app available please update it now.";

        return Platform.isIOS
            ? CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: alertButtons,
        )
            : WillPopScope(
          onWillPop: () {
            Navigator.of(context).pop();
            return Future.value(false);
          },
          child: AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: alertButtons,
          ),
        );
      },
    );
  }

  List<Widget> _buildButtonsForForceUpdateAlert(context, String storeUrl, bool isForceUpdateOn, double newversion) {
    String btnLabel = "Update Now";
    String btnLabelCancel = "Later";
    List<Widget> alertButtons = isForceUpdateOn
        ? [
      TextButton(
        child: Text(btnLabel),
        onPressed: () => _launchURL(storeUrl),
      )
    ]
        : [
      TextButton(
        child: Text(btnLabel),
        onPressed: () => _launchURL(storeUrl),
      ),
      TextButton(
        child: Text(btnLabelCancel),
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("skipedVersion", newversion.toString());
          navigationPage();
        },
      )
    ];
    return alertButtons;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => (IntroScreen())));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/splashscreen2.png"),
                fit: BoxFit.fill)),
        /*child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Opacity(
                  opacity: opacity.value,
                  child: Center(
                      child: new Image.asset('assets/Login/fmc_logo.png')),
                ),
              ]),
        ) */);
  }
}
