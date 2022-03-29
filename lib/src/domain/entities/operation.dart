class Operation {
  final int? id;
  final int userTo;
  final int cardTo;
  final int userFrom;
  final int cardFrom;
  final String text;
  final String value;
  final String status;
  final String? time;

  const Operation({
    this.id,
    required this.userTo,
    required this.cardTo,
    required this.userFrom,
    required this.cardFrom,
    required this.text,
    required this.value,
    required this.status,
    this.time,
  });
}
