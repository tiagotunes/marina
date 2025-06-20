import 'dart:convert';

import 'package:marina/src/domain/data/models/domain_model.dart';
import 'package:marina/src/domain/domain/entities/domain.dart';
import 'package:marina/core/common/entities/user.dart';
import 'package:marina/core/utils/typedefs.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.gender,
    required super.domains,
    required super.status,
    required super.admin,
  });

  const UserModel.empty()
    : this(
        id: 'empty',
        name: 'empty',
        email: 'empty',
        gender: null,
        domains: const [],
        status: 'inactive',
        admin: true,
      );

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? gender,
    List<Domain>? domains,
    String? status,
    bool? admin,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      domains: domains ?? this.domains,
      status: status ?? this.status,
      admin: admin ?? this.admin,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      if (gender != null) 'gender': gender,
      'domains':
          domains.map((domain) => (domain as DomainModel).toMap()).toList(),
      'status': status,
      'admin': admin,
    };
  }

  factory UserModel.fromJson(String source) {
    return UserModel.fromMap(jsonDecode(source) as DataMap);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String? ?? map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String?,
      domains:
          List<DataMap>.from(
            map['domains'] as List,
          ).map(DomainModel.fromMap).toList(),
      status: map['status'] as String,
      admin: map['admin'] as bool,
    );
  }

  String toJson() => jsonEncode(toMap());
}
