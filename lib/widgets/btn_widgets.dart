import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  var btnText ="";
  var onClick;


  ButtonWidget({required this.btnText, this.onClick});
  Color yellowColors = Colors.yellow[700] ?? Color(1);
  Color yellowColor = Colors.yellow[700] ?? Color(1);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [yellowColors,yellowColor],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight),
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
