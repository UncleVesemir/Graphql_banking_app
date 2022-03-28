import 'dart:convert';

import 'package:banking/src/domain/entities/friend_card.dart';

part 'friend_card_mapper.dart';

FriendCardModel friendCardModelFromJson(String str) =>
    FriendCardModel.fromJson(json.decode(str));

String friendCardModelToJson(FriendCardModel data) =>
    json.encode(data.toJson());

class FriendCardModel extends FriendCard {
  FriendCardModel({
    required int cardId,
    required String cardNumber,
    required String cardType,
  }) : super(
          cardId: cardId,
          cardNumber: cardNumber,
          type: cardType,
        );

  factory FriendCardModel.fromJson(Map<String, dynamic> json) =>
      _$FriendCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendCardModelToJson(this);
}
