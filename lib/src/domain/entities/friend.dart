import 'package:banking/src/domain/entities/card.dart';

class Friend {
  final int id;
  final String name;
  final String? image;
  final List<Card>? cards;

  const Friend({
    required this.id,
    required this.name,
    this.image,
    this.cards,
  });
}
