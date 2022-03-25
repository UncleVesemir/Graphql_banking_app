import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CardClipper(),
      child: Container(
        color: Colors.deepOrange,
        width: 300,
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/mastercard.png')),
                  const Spacer(),
                  const Text('*5321', style: AppTextStyles.boldLowValueWhite),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('03/28', style: AppTextStyles.regularLowValueWhite),
                  SizedBox(height: 6),
                  Text('\$24,123', style: AppTextStyles.boldMediumValueWhite),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
