part of 'card.dart';

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      id: json['card_id'] as int,
      cvv: json['card_cvv'] as int,
      name: json['card_name'] as String,
      type: json['card_type'] as String,
      value: json['card_value'] as String,
      number: json['card_number'] as String,
      userId: json['card_user_id'] as int,
      expDate: json['card_exp_date'] as String,
    );

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'card_id': instance.id,
      'card_cvv': instance.cvv,
      'card_name': instance.name,
      'card_type': instance.type,
      'card_value': instance.value,
      'card_number': instance.number,
      'card_user_id': instance.userId,
      'card_exp_date': instance.expDate,
    };
