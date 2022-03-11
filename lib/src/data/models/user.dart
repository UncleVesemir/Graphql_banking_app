import 'dart:convert';

import 'package:banking/src/domain/entities/card.dart';
import 'package:banking/src/domain/entities/user.dart';

part 'user_mapper.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  const UserModel({
    required String uuid,
    required String name,
    required String email,
    required String password,
    required int id,
    List<Card>? cards,
  }) : super(
          uuid: uuid,
          name: name,
          email: email,
          password: password,
          id: id,
          cards: cards,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
