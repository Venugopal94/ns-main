import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:robustremedy/themes/app_colors.dart';
import 'package:robustremedy/themes/light_color.dart';
import 'package:robustremedy/themes/ui_helper.dart';
import 'package:robustremedy/widgets/responsive.dart';

class visionmissionBannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isTabletDesktop = Responsive.isTabletDesktop(context);
    final cardWidth =
        MediaQuery.of(context).size.width / (isTabletDesktop ? 3.8 : 1.2);

    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.arrow_downward,
                color: LightColor.midnightBlue,
              ),
              UIHelper.horizontalSpaceExtraSmall(),
              Flexible(
                child: Text(
                  "Find Your Special Someone",
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: LightColor.midnightBlue,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              UIHelper.horizontalSpaceExtraSmall(),
              Icon(
                Icons.arrow_downward,
                color: LightColor.midnightBlue,
              ),
            ],
          ),
          UIHelper.verticalSpaceMedium(),
          LimitedBox(
            maxHeight: 220.0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(right: 10.0),
                padding: const EdgeInsets.all(10.0),
                width: cardWidth,
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  border: Border.all(color: LightColor.midnightBlue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Start Interacting',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: LightColor.midnightBlue,
                                  ),
                                ),
                                UIHelper.verticalSpaceExtraSmall(),
                                Text(
                                  'Our customers always come first. We will take time to listen to you and respond '
                                      'to your needs.',

                                  style: GoogleFonts.montserrat(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          UIHelper.verticalSpaceExtraSmall(),
                          TextButton(
                            child: Text(
                              'Call Us',
                              style: GoogleFonts.montserrat(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: LightColor.midnightBlue,
                              ),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall(),
                    ClipOval(
                      child: Image.asset(
                        'assets/aboutus.jpeg',
                        height: 100.0,
                        width: 100.0,
                      ),
                    )
                  ],
                ),
              ),

            ),

          )
        ],
      ),
    );
  }
}
