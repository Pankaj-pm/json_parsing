// To parse this JSON data, do
//
//     final userResModel = userResModelFromJson(jsonString);

import 'dart:convert';

UserResModel userResModelFromJson(String str) => UserResModel.fromJson(json.decode(str));

String userResModelToJson(UserResModel data) => json.encode(data.toJson());

class UserResModel {
  String? name;
  String? job;
  String? email;
  String? pass;
  String? id;
  DateTime? createdAt;

  UserResModel({
    this.name,
    this.job,
    this.email,
    this.pass,
    this.id,
    this.createdAt,
  });

  factory UserResModel.fromJson(Map<String, dynamic> json) => UserResModel(
    name: json["name"],
    job: json["job"],
    email: json["email"],
    pass: json["pass"],
    id: json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "job": job,
    "email": email,
    "pass": pass,
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
  };
}
