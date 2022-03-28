part of 'friend_card.dart';

FriendCardModel _$FriendCardModelFromJson(Map<String, dynamic> json) =>
    FriendCardModel(
      cardId: json['card_id'] as int,
      cardNumber: json['card_number'] as String,
      cardType: json['card_type'] as String,
    );

Map<String, dynamic> _$FriendCardModelToJson(FriendCardModel instance) =>
    <String, dynamic>{
      'card_id': instance.cardId,
      'card_number': instance.cardNumber,
      'card_type': instance.type,
    };
