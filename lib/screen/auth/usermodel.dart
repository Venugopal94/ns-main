import 'package:flutter/cupertino.dart';

class UserModel {
  final String zone;
  final String area;
  final String id;

  UserModel(
      {@required this.id, this.zone, @required this.area});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],

      zone: json["zone"],
      area: json["area"],
    );
  }

  static List<UserModel> fromJsonList(List list) {
    return list.map((item) => UserModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.zone}';
  }

  ///this method will prevent the override of toString


  ///custom comparing function to check if two users are equal
  bool isEqual(UserModel model) {
    return this.id == model?.id;
  }

  @override
  String toString() => zone+' '+area;
}