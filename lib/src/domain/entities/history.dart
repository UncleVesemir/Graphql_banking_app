class History {
  History({
    required this.value,
    required this.time,
    required this.isProfit,
    required this.transactionId,
    required this.transactionIdTo,
    required this.transactionIdFrom,
  });

  final String value;
  final DateTime time;
  final bool isProfit;
  final int transactionId;
  final int transactionIdTo;
  final int transactionIdFrom;

  @override
  List<Object> get props {
    return [
      time,
      value,
      isProfit,
      transactionId,
      transactionIdTo,
      transactionIdFrom,
    ];
  }
}
