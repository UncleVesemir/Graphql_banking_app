part of 'user.dart';

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['user_id'] as int,
      uuid: json['user_uuid'] != null ? json['user_uuid'] as String : '',
      name: json['user_name'] as String,
      email: json['user_email'] as String,
      image: json['user_image'] != null ? json['user_image'] as String : null,
      password:
          json['user_password'] != null ? json['user_password'] as String : '',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_id': instance.id,
      'user_uuid': instance.uuid,
      'user_name': instance.name,
      'user_email': instance.email,
      'user_image': instance.image,
      'user_password': instance.password,
    };
