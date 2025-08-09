import 'package:marina/common/utils/typedefs.dart';

class UserProfile {
  String? id;
  String? name;
  String? email;
  String? gender;
  // final List<Domain> domains;
  String? status;
  bool? admin;
  String? accessToken;

  UserProfile({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.status,
    this.admin,
    this.accessToken,
  });

  factory UserProfile.fromJson(DataMap json) {
    return UserProfile(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      status: json['status'],
      admin: json['admin'],
      accessToken: json['accessToken'],
    );
  }

  DataMap toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "gender": gender,
    "status": status,
    "admin": admin,
    "accessToken": accessToken,
  };
}
