import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/widgets/card/add_credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:banking/src/domain/entities/card.dart' as card;

class AddCardDialog extends StatefulWidget {
  final CardsState state;
  const AddCardDialog({
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  State<AddCardDialog> createState() => _AddCardDialogState();
}

class _AddCardDialogState extends State<AddCardDialog> {
  bool _checked = false;
  String cardName = '';
  String cardNumber = '';
  String cardExpDate = '';
  int cardCvv = 0;

  void _addCard() async {
    final CardsBloc cardsBloc = BlocProvider.of<CardsBloc>(context);
    final SignInRegisterBloc userBloc =
        BlocProvider.of<SignInRegisterBloc>(context);
    var state = userBloc.state as SignInRegisterLoadedState;
    cardsBloc.add(
      AddCardEvent(
        card: card.Card(
          name: cardName,
          number: cardNumber,
          expDate: cardExpDate,
          cvv: cardCvv,
          value: '1000',
          userId: state.user.id,
          type: 'visa',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardsBloc, CardsState>(
      listener: (context, state) {
        if (state is CardsLoadedState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: widget.state is! CardsLoadingState
                    ? GestureDetector(
                        onTap: _checked ? () async => _addCard() : null,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: _checked
                                ? AppColors.appBackgroundGradient
                                : AppColors.appBackgroundGradientInactive,
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 35,
                          ),
                        ),
                      )
                    : const SizedBox(
                        width: 60,
                        height: 60,
                        child: SpinKitWave(color: Colors.white),
                      ),
              ),
            ),
          ],
          content: AddCreditCardItem(
            width: 350,
            height: 240,
            gradient: AppColors.appBackgroundGradient,
            onComplete: (name, number, expDate, cvv) {
              setState(() {
                cardName = name;
                cardNumber = number;
                cardExpDate = expDate;
                cardCvv = cvv;
              });
            },
            onChecked: (value) {
              setState(() {
                _checked = value;
              });
            },
          ),
        );
      },
    );
  }
}
