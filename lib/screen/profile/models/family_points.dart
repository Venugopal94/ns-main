class FamilyPoints {
  String? userId;
  String? firstName;
  String? lastName;
  String? mobile;
  String? familyPoints;
  String? expiry;
  String? description;
  String? card;
  String? pointamount;

  FamilyPoints(
      {this.userId,
        this.firstName,
        this.lastName,
        this.mobile,
        this.card,
        this.description,
        this.familyPoints,
        this.expiry,
        this.pointamount});

  FamilyPoints.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['firstname'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    card = json['card'];
    description = json['description'];
    familyPoints = json['family_points'];
    expiry = json['expiry'];
    pointamount = json['pointamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile'] = this.mobile;
    data['family_points'] = this.familyPoints;
    data['expiry'] = this.expiry;
    data['pointamount'] = this.pointamount;
    return data;
  }
}