import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/utils/func_utils.dart';
import 'package:banking/src/presentation/views/friends.dart';
import 'package:banking/src/presentation/views/history.dart';
import 'package:banking/src/presentation/views/settings/settings.dart';
import 'package:banking/src/presentation/widgets/bottom_app_bar.dart';
import 'package:banking/src/presentation/widgets/card/add_credit_card.dart';
import 'package:banking/src/presentation/widgets/card/credit_card_item.dart';
import 'package:banking/src/presentation/widgets/card/credit_card_widget.dart';
import 'package:banking/src/domain/entities/card.dart' as card;
import 'package:banking/src/presentation/widgets/custom_clip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSheetExpanded = false;
  int _selectedIndex = 0;
  int? _selectedCardIndex;

  List<CreditCardItem> cards = [];

  void _showCardDialog(CardsState state) {
    showDialog(
      context: context,
      builder: (context) {
        return AddCardDialog(state: state);
      },
    );
  }

  void _onCardSelected(int? item) {
    setState(() {
      _selectedCardIndex = item;
    });
  }

  Widget _buildCardsInfo() {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: _selectedCardIndex != null
            ? ClipShadowPath(
                shadow: Shadow(
                  offset: const Offset(0, 0),
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                ),
                clipper: SettingsCardClipper(),
                child: Container(
                  color: Colors.white,
                ),
              )
            : Container(),
      ),
    );
  }

  Widget _userCards() {
    return Flexible(
      flex: 6,
      child: ClipPath(
        clipper: SheetClipper(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: BlocBuilder<CardsBloc, CardsState>(
            builder: (context, state) {
              if (state is CardsLoadedState) {
                return Column(
                  children: [
                    Flexible(
                      child: CreditCards3d(
                        children: state.card,
                        // onSelected: (item) => _onCardSelected(item),
                        onSelected: (item) => {},
                      ),
                    ),
                    const SizedBox(height: 90),
                  ],
                );
              }
              if (state is CardsLoadingState) {
                return const Center(
                  child: SpinKitWave(color: Colors.black),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(CardsState state) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: AppColors.appBackgroundGradientDecoration,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: AppColors.appBackgroundGradientDecoration,
            child: _selectedIndex == 0
                ? Column(
                    children: [
                      const SizedBox(height: 120),
                      _buildCardsInfo(),
                      _userCards(),
                    ],
                  )
                : _selectedIndex == 1
                    ? FriendsPage()
                    : _selectedIndex == 2
                        ? const SettingsPage()
                        : const HistoryPage(),
          ),
          CustomAppBar(
            onSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(CardsState state) {
    var userState = BlocProvider.of<SignInRegisterBloc>(context).state
        as SignInRegisterLoadedState;
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: _selectedIndex == 1 ? Colors.white : Colors.transparent,
      elevation: 0,
      leading: null,
      automaticallyImplyLeading: false,
      actions: _selectedIndex == 0
          ? [
              Row(
                children: [
                  GestureDetector(
                    onTap: () async => _showCardDialog(state),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          center: Alignment.topLeft,
                          radius: 0.85,
                          colors: [
                            Colors.yellowAccent.withOpacity(0.6),
                            Colors.deepOrange.withOpacity(1),
                            // Colors.grey.withOpacity(0.2),
                            // Colors.black.withOpacity(0.9),
                          ],
                        ),
                      ),
                      child:
                          const Icon(Icons.add, color: Colors.white, size: 15),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ]
          : [],
      centerTitle: false,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(FuncUtils.getCurrentDateFormatted(),
              style: AppTextStyles.loginGrey),
          Text('Hey, ${userState.user.name}!',
              style: AppTextStyles.boldMediumValueBlack),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardsBloc, CardsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var _state = BlocProvider.of<SignInRegisterBloc>(context).state;
        var _st = _state as SignInRegisterLoadedState;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(state),
          body: _buildBody(state),
        );
      },
    );
  }
}

// class UserCards extends StatelessWidget {
//   final Function(int?) onSelected;
//   const UserCards({
//     required this.onSelected,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

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
