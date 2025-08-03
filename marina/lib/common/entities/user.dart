class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.gender,
    // required this.domains,
    required this.status,
    required this.admin,
  });

  const User.empty()
    : id = 'empty',
      name = 'empty',
      email = 'empty',
      gender = null,
      // domains = const [],
      status = 'inactive',
      admin = true;

  final String id;
  final String name;
  final String email;
  final String? gender;
  // final List<Domain> domains;
  final String status;
  final bool admin;
}
