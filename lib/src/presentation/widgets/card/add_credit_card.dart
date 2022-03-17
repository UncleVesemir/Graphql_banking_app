import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/func_utils.dart';
import 'package:flutter/material.dart';

class AddCreditCardItem extends StatefulWidget {
  final double width;
  final double height;
  final LinearGradient? gradient;
  final Color? color;
  final Function(bool value) onChecked;
  const AddCreditCardItem({
    required this.onChecked,
    required this.width,
    required this.height,
    this.color,
    this.gradient,
    Key? key,
  }) : super(key: key);

  @override
  State<AddCreditCardItem> createState() => _AddCreditCardItemState();
}

class _AddCreditCardItemState extends State<AddCreditCardItem> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardCvvController = TextEditingController();
  final TextEditingController _cardExpDateController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();

  void _checkFields() {
    setState(() {
      if (_cardCvvController.text.isNotEmpty &&
          _cardExpDateController.text.isNotEmpty &&
          _cardNameController.text.isNotEmpty &&
          _cardNumberController.text.isNotEmpty) {
        widget.onChecked(true);
      } else {
        widget.onChecked(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20.0,
            spreadRadius: 1.0,
            offset: const Offset(0.0, 1.0), // shadow direction: bottom right
          )
        ],
        color: widget.color,
        gradient: widget.gradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, bottom: 18, right: 24, top: 18),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              inputFormatters: FuncUtils.getFormatter(TextFieldType.creditCard),
              textAlign: TextAlign.start,
              controller: _cardNumberController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'XXXX XXXX XXXX XXXX',
              ),
              style: AppTextStyles.creditCardBig,
              scrollPadding: EdgeInsets.zero,
              onChanged: (value) => _checkFields(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35),
              child: TextFormField(
                inputFormatters: FuncUtils.getFormatter(TextFieldType.cvv),
                scrollPadding: EdgeInsets.zero,
                textAlign: TextAlign.end,
                controller: _cardCvvController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'CVV',
                ),
                onChanged: (value) => _checkFields(),
                style: TextStyle(
                    fontSize: 13, color: Colors.black.withOpacity(0.5)),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 200,
                        child: TextFormField(
                          inputFormatters: FuncUtils.getFormatter(
                              TextFieldType.expirationDate),
                          controller: _cardExpDateController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'DD/YY',
                          ),
                          onChanged: (value) => _checkFields(),
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 20,
                        width: 300,
                        child: TextFormField(
                          inputFormatters:
                              FuncUtils.getFormatter(TextFieldType.name),
                          controller: _cardNameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'CARDHOLDER NAME',
                          ),
                          onChanged: (value) => _checkFields(),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
          ],
        ),
      ),
    );
  }
}
