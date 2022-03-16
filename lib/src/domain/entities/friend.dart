import 'package:banking/src/domain/entities/card.dart';

class Friend {
  final String name;
  final int id;
  final String? image;
  final List<Card>? cards;

  const Friend({required this.name, required this.id, this.cards, this.image});
}
