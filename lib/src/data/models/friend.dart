import 'package:banking/src/data/models/friend_card.dart';
import 'package:banking/src/domain/entities/friend.dart';
import 'package:banking/src/domain/entities/user.dart';

class FriendModel extends Friend {
  const FriendModel({
    required User info,
    required String status,
    List<FriendCardModel>? cards,
  }) : super(
          info: info,
          status: status,
          cards: cards,
        );
}
