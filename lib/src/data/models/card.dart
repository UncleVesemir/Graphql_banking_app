import 'dart:convert';

import 'package:banking/src/domain/entities/card.dart';

part 'card_mapper.dart';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel extends Card {
  const CardModel({
    int? id,
    required String name,
    required int cvv,
    required String expDate,
    required String value,
    required int userId,
    required String type,
    required String number,
  }) : super(
          id: id,
          name: name,
          cvv: cvv,
          expDate: expDate,
          value: value,
          userId: userId,
          type: type,
          number: number,
        );

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardModelToJson(this);
}
