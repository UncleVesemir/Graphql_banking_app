class Card {
  const Card({
    required this.name,
    required this.cvv,
    required this.expDate,
    required this.value,
    required this.number,
    this.id,
    required this.userId,
    required this.type,
  });
  final String name;
  final String number;
  final String expDate;
  final String value;
  final int cvv;
  final String type;
  final int? id;
  final int userId;

  @override
  List<Object> get props {
    return [
      name,
      expDate,
      value,
      type,
      userId,
    ];
  }
}
