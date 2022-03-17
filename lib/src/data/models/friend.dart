import 'package:banking/src/domain/entities/card.dart';
import 'package:banking/src/domain/entities/friend.dart';

class FriendModel extends Friend {
  const FriendModel({
    required int id,
    List<Card>? cards,
    required String name,
  }) : super(
          id: id,
          name: name,
          cards: cards,
        );
}
