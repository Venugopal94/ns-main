import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:http/http.dart' as http;

import '../../themes/light_color.dart';
import '../home/advertise.dart';
import 'models/banner.dart';

class LuckyDrawBanners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerData>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<BannerData> data = snapshot.data ?? [];
          return imageSlider(context, data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}", style: TextStyle(fontFamily: "Roboto"));
        }
        return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),
            ));
      },
    );
  }

  Future<List<BannerData>> _fetchJobs() async {
    final jobsListAPIUrl =
        'https://onlinefamilypharmacy.com/mobileapplication/e_static.php?action=lucky_draw_schedulesimage';
    final response = await http.get(Uri.parse( jobsListAPIUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new BannerData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Swiper imageSlider(context, data) {
  return Swiper(
    autoplay: true,
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return CachedNetworkImage(imageUrl:
      'https://onlinefamilypharmacy.com/images/luckdraw/' + data[index].banner,
        fit: BoxFit.fitWidth,
        width: 200,
        placeholder: (context, url) => Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.midnightBlue),)),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    },
    pagination: new SwiperPagination(
      alignment: Alignment.bottomCenter,
      builder: new DotSwiperPaginationBuilder(
          color: LightColor.yellowColor, activeColor: LightColor.midnightBlue),
    ),
    control: new SwiperControl(
      color: Color(0xff38547C),
    ),
    //viewportFraction: 0.2,
    scale: 1.0,
  );
}