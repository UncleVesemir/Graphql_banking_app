import 'dart:convert';

import 'package:banking/src/domain/entities/operation.dart';

part 'operation_mapper.dart';

OperationModel operationModelFromJson(String str) =>
    OperationModel.fromJson(json.decode(str));

String operationModelToJson(OperationModel data) => json.encode(data.toJson());

class OperationModel extends Operation {
  OperationModel({
    required int id,
    required String uuid,
    required String text,
    required String value,
    required String status,
    required int cardTo,
    required int userTo,
    required int cardFrom,
    required int userFrom,
    String? time,
  }) : super(
          id: id,
          uuid: uuid,
          text: text,
          time: time,
          value: value,
          status: status,
          cardTo: cardTo,
          userTo: userTo,
          cardFrom: cardFrom,
          userFrom: userFrom,
        );

  factory OperationModel.fromJson(Map<String, dynamic> json) =>
      _$OperationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OperationModelToJson(this);
}
