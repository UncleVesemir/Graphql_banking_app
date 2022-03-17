import 'package:banking/src/presentation/styles.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Colors.deepOrange,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Name', style: AppTextStyles.boldLowValueBlack),
                  SizedBox(height: 4),
                  Text('09, July, 2022',
                      style: AppTextStyles.regularLowValueGrey),
                ],
              ),
            ],
          ),
          const Text('+273\$', style: AppTextStyles.semiMediumValue),
        ],
      ),
    );
  }
}
