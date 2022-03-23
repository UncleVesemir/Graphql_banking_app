import 'package:banking/src/domain/entities/card.dart';
import 'package:banking/src/domain/entities/user.dart';

class Friend {
  final User info;
  final String status;
  final List<Card>? cards;

  const Friend({
    required this.info,
    required this.status,
    this.cards,
  });
}
