import 'package:flutter/material.dart';
import 'package:banking/src/domain/entities/card.dart' as card;

class CreditCardModel {
  final card.Card info;
  final LinearGradient? gradient;
  final Color? color;
  final double width;
  final double height;

  CreditCardModel({
    required this.info,
    required this.width,
    required this.height,
    this.gradient,
    this.color,
  });
}
