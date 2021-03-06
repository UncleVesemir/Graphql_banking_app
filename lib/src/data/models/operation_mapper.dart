part of 'operation.dart';

OperationModel _$OperationModelFromJson(Map<String, dynamic> json) =>
    OperationModel(
      id: json['id'] as int,
      uuid: json['uuid'] as String,
      time: json['time'] ?? '',
      text: json['text'] as String,
      value: json['value'] as String,
      status: json['status'] as String,
      cardTo: json['card_id_to'] as int,
      userTo: json['user_id_to'] as int,
      cardFrom: json['card_id_from'] as int,
      userFrom: json['user_id_from'] as int,
      senderName: json['sender_name'] as String,
      recipientName: json['recipient_name'] as String,
    );

Map<String, dynamic> _$OperationModelToJson(OperationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'text': instance.text,
      'value': instance.value,
      'status': instance.status,
      'card_id_to': instance.cardTo,
      'user_id_to': instance.userTo,
      'card_id_from': instance.cardFrom,
      'user_id_from': instance.userFrom,
      'sender_name': instance.senderName,
      'recipient_name': instance.recipientName,
    };
