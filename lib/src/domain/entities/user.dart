class User {
  const User({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
    required this.password,
    this.image,
  });

  final int id;
  final String uuid;
  final String name;
  final String email;
  final String password;
  final String? image;
}
