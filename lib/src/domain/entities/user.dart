import 'card.dart';

class User {
  const User({
    required this.uuid,
    required this.name,
    required this.email,
    required this.password,
    required this.id,
    this.cards,
  });

  final String uuid;
  final String name;
  final String email;
  final String password;
  final int id;
  final List<Card>? cards;

  @override
  List<Object> get props {
    return [
      uuid,
      name,
      email,
      password,
      id,
    ];
  }
}
