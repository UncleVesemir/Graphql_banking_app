import 'package:banking/src/presentation/widgets/card/credit_card_model.dart';
import 'package:flutter/material.dart';

class CreditCardItem extends StatelessWidget {
  final CreditCardModel cardInfo;
  const CreditCardItem({
    required this.cardInfo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardInfo.height,
      width: cardInfo.width,
      decoration: BoxDecoration(
        color: cardInfo.color,
        gradient: cardInfo.gradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 18, right: 24),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      cardInfo.info.expDate,
                      style: TextStyle(color: Colors.black.withOpacity(0.5)),
                    ),
                    Text(
                      cardInfo.info.name,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    )
                  ],
                )),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 40,
                    width: 80,
                    child: Image.asset(
                      'assets/images/mastercard.png',
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
