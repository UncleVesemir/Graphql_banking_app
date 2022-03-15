import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:flutter/material.dart';

class ReceiptDataWidget extends StatelessWidget {
  const ReceiptDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ClipPath(
          clipper: ReceiptClipper(),
          child: Container(
            width: double.infinity,
            height: 400,
            color: Colors.white,
          )),
    );
  }
}

class ReceiptInfoWidget extends StatelessWidget {
  final bool isProfit;
  const ReceiptInfoWidget({
    Key? key,
    required this.isProfit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ClipPath(
          clipper: ReceiptClipper(),
          child: Container(
            width: double.infinity,
            height: 80,
            color: isProfit ? AppColors.green : Colors.red[400],
          )),
    );
  }
}
