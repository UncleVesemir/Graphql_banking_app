import 'card_types.dart';
import 'history.dart';

class Card {
  Card({
    required this.userUuid,
    required this.cardName,
    required this.expDate,
    required this.value,
    required this.id,
    required this.userId,
    required this.type,
    this.history,
  });

  final String userUuid;
  final String cardName;
  final String expDate;
  final String value;
  final CardTypes type;
  final int id;
  final int userId;
  final List<History>? history;

  @override
  List<Object> get props {
    return [
      userUuid,
      cardName,
      expDate,
      value,
      type,
      id,
      userId,
    ];
  }
}
