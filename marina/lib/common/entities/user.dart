class LoginRequestEntity {
  String? name;
  String? email;
  String? gender;
  String? admin;

  LoginRequestEntity({this.name, this.email, this.gender, this.admin});

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "gender": gender,
    "admin": admin,
  };
}
