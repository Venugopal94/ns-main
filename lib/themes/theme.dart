import 'package:flutter/material.dart';

import 'light_color.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
      backgroundColor: LightColor.background,
      primaryColor: LightColor.primaryBackground,
      cardTheme: CardTheme(color: LightColor.background),
      textTheme: TextTheme(bodyText1: TextStyle(color: LightColor.black, fontFamily: "Roboto")),
      iconTheme: IconThemeData(color: LightColor.iconColor),
      bottomAppBarColor: LightColor.background,
      dividerColor: LightColor.lightGrey,
      primaryTextTheme:
          TextTheme(bodyText1: TextStyle(color: LightColor.titleTextColor, fontFamily: "Roboto")));

  static TextStyle titleStyle =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 16, fontFamily: "Roboto");
  static TextStyle subTitleStyle =
      const TextStyle(color: LightColor.subTitleTextColor, fontSize: 12, fontFamily: "Roboto");

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22, fontFamily: "Roboto");
  static TextStyle h3Style = const TextStyle(fontSize: 20, fontFamily: "Roboto");
  static TextStyle h4Style = const TextStyle(fontSize: 18, fontFamily: "Roboto");
  static TextStyle h5Style = const TextStyle(fontSize: 16, fontFamily: "Roboto");
  static TextStyle h6Style = const TextStyle(fontSize: 14, fontFamily: "Roboto");

  static List<BoxShadow> shadow = <BoxShadow>[
    BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];

  static EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 10,
  );

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
