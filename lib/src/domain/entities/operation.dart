class Operation {
  final int? id;
  final String? time;
  final String? uuid;
  final int userTo;
  final int cardTo;
  final int userFrom;
  final int cardFrom;
  final String text;
  final String value;
  final String status;

  const Operation({
    this.id,
    this.time,
    required this.uuid,
    required this.userTo,
    required this.cardTo,
    required this.userFrom,
    required this.cardFrom,
    required this.text,
    required this.value,
    required this.status,
  });
}
