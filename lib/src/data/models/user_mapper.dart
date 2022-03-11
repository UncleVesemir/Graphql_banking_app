part of 'user.dart';

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uuid: json['user_uuid'] as String,
      name: json['user_name'] as String,
      email: json['user_email'] as String,
      password: json['user_password'] as String,
      id: json['user_id'] as int,
      // cards: json['cards'] as List<Card>,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_uuid': instance.uuid,
      'user_name': instance.name,
      'user_email': instance.email,
      'user_password': instance.password,
      'user_id': instance.id,
      // 'cards': instance.cards,
    };
