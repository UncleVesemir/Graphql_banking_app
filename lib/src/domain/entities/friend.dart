import 'package:banking/src/data/models/friend_card.dart';
import 'package:banking/src/domain/entities/user.dart';

class Friend {
  final User info;
  final String status;
  final List<FriendCardModel>? cards;

  const Friend({
    required this.info,
    required this.status,
    this.cards,
  });
}
