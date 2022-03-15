part of 'user.dart';

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uuid: json['user_uuid'] as String,
      name: json['user_name'] as String,
      email: json['user_email'] as String,
      password: json['user_password'] as String,
      id: json['user_id'] as int,
      image: json['user_image'] != null ? json['user_image'] as String : null,
      // image: json['user_image'] as String,
      // cards: json['cards'] != null ? json['cards'] as List<Card> : null,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_uuid': instance.uuid,
      'user_name': instance.name,
      'user_email': instance.email,
      'user_password': instance.password,
      'user_id': instance.id,
      'user_image': instance.image,
      // 'cards': instance.cards,
    };
