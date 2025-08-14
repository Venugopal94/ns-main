class LuckyDraw {
  String? drawName;
  String? drawDate;

  LuckyDraw({this.drawName, this.drawDate});

  LuckyDraw.fromJson(Map<String, dynamic> json) {
    drawName = json['draw_name'];
    drawDate = json['draw_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['draw_name'] = this.drawName;
    data['draw_date'] = this.drawDate;
    return data;
  }
}
