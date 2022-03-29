import 'package:banking/src/domain/entities/operation.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/widgets/custom_clip.dart';
import 'package:flutter/material.dart';

class ReceiptDataWidget extends StatelessWidget {
  final bool isSended;
  final Operation operation;
  const ReceiptDataWidget({
    required this.isSended,
    required this.operation,
    Key? key,
  }) : super(key: key);

  Widget _rowItem(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: AppTextStyles.receiptLow,
        ),
        Text(
          right,
          style: AppTextStyles.receiptLowBold,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
      child: ClipShadowPath(
        shadow: Shadow(
          offset: const Offset(0, 1),
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 10,
        ),
        clipper: SettingsCardClipper(),
        child: Container(
          width: double.infinity,
          height: 420,
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 35, right: 35, top: 35, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isSended ? 'Transfer Sended' : 'Transfer Received',
                  style: AppTextStyles.receiptBig
                      .copyWith(color: 3 < 2 ? Colors.grey : Colors.black),
                ),
                const SizedBox(height: 20),
                _rowItem('Date:', operation.time!.substring(11)),
                _rowItem('Transfer from:', operation.userFrom.toString()),
                _rowItem('Transfer to:', operation.userTo.toString()),
                _rowItem('Transfer unique id:', operation.id.toString()),
                _rowItem('Operation status:', operation.status),
                const SizedBox(height: 30),
                _rowItem('Total:', '\$${operation.value}'),
                _rowItem('Taxes:', '\$0'),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: AppTextStyles.receiptMedium,
                    ),
                    Text(
                      '\$${operation.value}',
                      style: AppTextStyles.receiptMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
      padding: const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
      child: ClipPath(
        clipper: ReceiptClipper(),
        child: Container(
          width: double.infinity,
          height: 50,
          color: isProfit ? AppColors.green : Colors.red[400],
          child: Column(
              // children: [Text('Money Transfer')],
              ),
        ),
      ),
    );
  }
}
