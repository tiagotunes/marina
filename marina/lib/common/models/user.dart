import 'package:marina/common/utils/typedefs.dart';

class UserProfile {
  String? accessToken;
  String? name;
  String? email;
  String? gender;
  // final List<Domain> domains;
  bool? admin;
  String? status;

  UserProfile({
    this.accessToken,
    this.name,
    this.email,
    this.gender,
    this.admin,
    this.status,
  });

  factory UserProfile.fromJson(DataMap json) {
    return UserProfile(
      accessToken: json['accessToken'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      admin: json['admin'],
      status: json['status'],
    );
  }

  DataMap toJson() => {
    "accessToken": accessToken,
    "name": name,
    "email": email,
    "gender": gender,
    "admin": admin,
    "status": status,
  };
}
