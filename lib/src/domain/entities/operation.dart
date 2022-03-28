class Operation {
  final int? id;
  final int userFrom;
  final int userTo;
  final int cardFrom;
  final int cardTo;
  final String status;
  final String value;

  const Operation({
    this.id,
    required this.userFrom,
    required this.userTo,
    required this.cardFrom,
    required this.cardTo,
    required this.status,
    required this.value,
  });
}
