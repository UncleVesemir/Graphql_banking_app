import 'package:banking/src/domain/entities/operation.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/widgets/custom_clip.dart';
import 'package:flutter/material.dart';

class ReceiptDataWidget extends StatelessWidget {
  final bool isSended;
  final Operation operation;
  final SignInRegisterLoadedState user;
  const ReceiptDataWidget({
    required this.user,
    required this.isSended,
    required this.operation,
    Key? key,
  }) : super(key: key);

  Widget _rowItem(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            left,
            style: AppTextStyles.receiptLow,
          ),
        ),
        Flexible(
          flex: 5,
          child: Text(
            right,
            textAlign: TextAlign.end,
            style: AppTextStyles.receiptLowBold,
          ),
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
                _rowItem('Date:', operation.time!),
                _rowItem('From:', operation.senderName),
                _rowItem('To:', operation.recipientName),
                _rowItem('Unique id:', operation.uuid.toString()),
                _rowItem('Message:', operation.text),
                _rowItem('Status:', operation.status),
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
