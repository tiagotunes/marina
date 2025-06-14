import 'package:equatable/equatable.dart';
import 'package:marina/core/common/entities/domain.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.gender,
    required this.domains,
    required this.status,
    required this.admin,
  });

  const User.empty()
    : id = 'empty',
      name = 'empty',
      email = 'empty',
      gender = null,
      domains = const [],
      status = 'inactive',
      admin = true;

  final String id;
  final String name;
  final String email;
  final String? gender;
  final List<Domain> domains;
  final String status;
  final bool admin;

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    gender,
    domains.length,
    status,
    admin,
  ];
}
