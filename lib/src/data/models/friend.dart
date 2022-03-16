import 'package:banking/src/domain/entities/card.dart';
import 'package:banking/src/domain/entities/friend.dart';

class FriendModel extends Friend {
  const FriendModel({
    required String name,
    required int id,
    List<Card>? cards,
  }) : super(
          id: id,
          cards: cards,
          name: name,
        );
}
