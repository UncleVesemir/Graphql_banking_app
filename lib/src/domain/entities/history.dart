class History {
  History({
    required this.transactionId,
    required this.transactionIdFrom,
    required this.transactionIdTo,
    required this.value,
    required this.isProfit,
    required this.time,
  });

  final int transactionId;
  final int transactionIdFrom;
  final int transactionIdTo;
  final String value;
  final bool isProfit;
  final DateTime time;

  @override
  List<Object> get props {
    return [
      transactionId,
      transactionIdFrom,
      transactionIdTo,
      value,
      isProfit,
      time,
    ];
  }
}
