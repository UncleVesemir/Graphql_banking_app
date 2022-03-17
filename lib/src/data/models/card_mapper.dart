part of 'card.dart';

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      name: json['card_name'] as String,
      id: json['card_id'] as int,
      expDate: json['card_exp_date'] as String,
      value: json['card_value'] as String,
      type: json['card_type'] as String,
      cvv: json['card_cvv'] as int,
      userId: json['card_user_id'] as int,
      number: json['card_number'] as String,
    );

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'card_name': instance.name,
      'card_id': instance.id,
      'card_exp_date': instance.expDate,
      'card_value': instance.value,
      'card_type': instance.type,
      'card_cvv': instance.cvv,
      'card_user_id': instance.userId,
      'card_number': instance.number,
    };
