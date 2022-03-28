import 'dart:convert';

import 'package:banking/src/data/models/friend_card.dart';
import 'package:banking/src/domain/entities/friend_card.dart';
import 'package:banking/src/domain/entities/user.dart';

part 'user_mapper.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  const UserModel({
    required int id,
    required String uuid,
    required String name,
    required String email,
    required String password,
    String? image,
  }) : super(
          id: id,
          uuid: uuid,
          name: name,
          email: email,
          password: password,
          image: image,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
