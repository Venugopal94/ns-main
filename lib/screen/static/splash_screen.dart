import 'package:flutter/material.dart';

import 'package:robustremedy/screen/intro_screen/screen.dart';

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
      navigationPage();
    });
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
