part of 'operation.dart';

OperationModel _$OperationModelFromJson(Map<String, dynamic> json) =>
    OperationModel(
      id: json['id'] as int,
      value: json['value'] as String,
      status: json['status'] as String,
      cardTo: json['card_id_to'] as int,
      userTo: json['user_id_to'] as int,
      cardFrom: json['card_id_from'] as int,
      userFrom: json['user_id_from'] as int,
    );

Map<String, dynamic> _$OperationModelToJson(OperationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'status': instance.status,
      'card_id_to': instance.cardTo,
      'user_id_to': instance.userTo,
      'card_id_from': instance.cardFrom,
      'user_id_from': instance.userFrom,
    };
