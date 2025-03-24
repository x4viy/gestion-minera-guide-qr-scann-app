class UserSystem {
  final int id;
  final String name;
  final String lastname;
  final String? password;
  final String? status;
  final bool isAdmin;
  final String email;
  final String numberIdentification;
  final String? role;

  const UserSystem({
    required this.id,
    required this.name,
    required this.lastname,
    this.password,
    this.status,
    required this.isAdmin,
    required this.email,
    required this.numberIdentification,
    this.role,
  });
}
