import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:robustremedy/screen/Item_group_screen/item_main.dart';
import 'package:robustremedy/screen/static/Contact_Us.dart';
import 'package:robustremedy/themes/app_colors.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/themes/ui_helper.dart';
import 'package:robustremedy/widgets/responsive.dart';

class aboutus_detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isTabletDesktop = Responsive.isTabletDesktop(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Column(
        children: <Widget>[

          if (!isTabletDesktop)
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  child: Container(
                    width: 10.0,
                    height: 140.0,
                    color: LightColor.primaryBackground,
                  ),
                ),
                UIHelper.horizontalSpaceMedium(),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Welcome To Family Pharmacy',
                        style: GoogleFonts.montserrat(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Text(
                        'Our customers always come first. We will take time to listen to you and respond to your needs. '
                        'We will be happy to get any feedback that can improve/motivate us to better our services '
                        'to you.',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          UIHelper.verticalSpaceMedium(),
        ],
      ),
    );
  }
}
