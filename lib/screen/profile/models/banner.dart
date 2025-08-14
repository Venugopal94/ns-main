class BannerData {
  String? banner;

  BannerData({this.banner});

  BannerData.fromJson(Map<String, dynamic> json) {
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner'] = this.banner;
    return data;
  }
}