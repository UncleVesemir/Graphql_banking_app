class Card {
  const Card({
    this.id,
    required this.cvv,
    required this.name,
    required this.type,
    required this.value,
    required this.number,
    required this.userId,
    required this.expDate,
  });
  final int? id;
  final int? cvv;
  final String name;
  final String type;
  final String value;
  final String number;
  final int userId;
  final String expDate;
}
