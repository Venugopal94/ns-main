class Coupon {
  String? userId;
  String? couponimage;
  String? drawName;
  String? description;
  String? drawTitle;
  String? luckyDrawItems;
  String? drawdate;
  String? billdate;
  String? billno;
  String? validfrom;
  String? validtill;
  String? coupon;

  Coupon(
      {this.userId,
        this.couponimage,
        this.drawName,
        this.description,
        this.drawTitle,
        this.luckyDrawItems,
        this.drawdate,
        this.billdate,
        this.billno,
        this.validfrom,
        this.validtill,
        this.coupon});


  Coupon.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    couponimage = json['couponimage'];
    drawName = json['draw_name'];
    description = json['description'];
    drawTitle = json['draw_title'];
    luckyDrawItems = json['lucky_draw_items'];
    drawdate = json['drawdate'];
    billdate = json['billdate'];
    billno = json['billno'];
    validfrom = json['validfrom'];
    validtill = json['validtill'];
    coupon = json['coupon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['couponimage'] = this.couponimage;
    data['draw_name'] = this.drawName;
    data['description'] = this.description;
    data['draw_title'] = this.drawTitle;
    data['lucky_draw_items'] = this.luckyDrawItems;
    data['drawdate'] = this.drawdate;
    data['billdate'] = this.billdate;
    data['billno'] = this.billno;
    data['validfrom'] = this.validfrom;
    data['validtill'] = this.validtill;
    data['coupon'] = this.coupon;
    return data;
  }
}