import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:robustremedy/screen/Item_group_screen/item_main.dart';
import 'package:robustremedy/screen/static/Contact_Us.dart';
import 'package:robustremedy/themes/app_colors.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/themes/ui_helper.dart';
import 'package:robustremedy/widgets/responsive.dart';

class aboutus_intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isTabletDesktop = Responsive.isTabletDesktop(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Column(
        children: <Widget>[
          if (!isTabletDesktop) UIHelper.verticalSpaceLarge(),
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: InkWell(
                  child: Container(
                    height: 150.0,
                    color: LightColor.yellowColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: FractionallySizedBox(
                            widthFactor: 0.7,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'All Categories',
                                    style:  GoogleFonts.montserrat(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: LightColor.midnightBlue,
                                    ),
                                  ),
                                  UIHelper.verticalSpaceExtraSmall(),
                                  Text(
                                    'Get best deals on products',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: LightColor.midnightBlue,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 45.0,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          color: LightColor.lightyellow,
                          child: Row(
                            children: <Widget>[
                              Text(
                                'View all',
                                style: GoogleFonts.montserrat(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: LightColor.midnightBlue,
                                ),
                              ),
                              UIHelper.horizontalSpaceSmall(),
                              Icon(
                                Icons.arrow_forward,
                                color: LightColor.midnightBlue,
                                size: 18.0,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: isTabletDesktop
                      ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Item_main()));
                  }
                      : () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Item_main()));
                  },
                ),
              ),
              Positioned(
                top: 0.0,
                right: 10.0,
                child: ClipOval(
                  child: Image.asset(
                    'assets/medicine.png',
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          UIHelper.verticalSpaceMedium(),
        ],
      ),
    );
  }
}
