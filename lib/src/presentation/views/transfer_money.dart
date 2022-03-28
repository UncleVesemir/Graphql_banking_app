import 'package:banking/src/domain/entities/operation.dart';
import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/blocs/friends/friends_bloc.dart';
import 'package:banking/src/presentation/blocs/operations/operations_bloc_bloc.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/widgets/animated_button.dart';
import 'package:banking/src/presentation/widgets/card/credit_card_item.dart';
import 'package:banking/src/presentation/widgets/custom_clip.dart';
import 'package:banking/src/presentation/widgets/custom_list_wheel.dart';
import 'package:banking/src/presentation/widgets/decrease_button.dart';
import 'package:banking/src/presentation/widgets/increase_button.dart';
import 'package:banking/src/domain/entities/card.dart' as card;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MoneyTransferScreen extends StatefulWidget {
  const MoneyTransferScreen({Key? key}) : super(key: key);

  @override
  State<MoneyTransferScreen> createState() => _MoneyTransferScreenState();
}

class _MoneyTransferScreenState extends State<MoneyTransferScreen> {
  double value = 0;
  List<Widget> cards = const [];

  CreditCardItem? selectedCard;
  int selectedFriend = 0;

  List<CreditCardItem> items = [];

  @override
  void initState() {
    super.initState();
    if (items.isNotEmpty) {
      selectedCard = items[0];
    }
  }

  void _increaseValue() => setState(() => value++);

  void _decreaseValue() => setState(() {
        if (value > 0) value--;
      });

  void _transferMoney() {
    var friendsState = BlocProvider.of<FriendsBloc>(context).state;
    var cardsState = BlocProvider.of<CardsBloc>(context).state;
    var userState = BlocProvider.of<SignInRegisterBloc>(context).state;

    if (friendsState is FriendsLoadedState &&
        cardsState is CardsLoadedState &&
        userState is SignInRegisterLoadedState) {
      var friendCards = friendsState.friends[selectedFriend].cards;
      if (friendCards != null && friendCards.isNotEmpty) {
        BlocProvider.of<OperationsBloc>(context).add(
          AddOperationEvent(
            operation: Operation(
              userFrom: userState.user.id,
              userTo: friendsState.friends[selectedFriend].info.id,
              cardFrom: selectedCard!.cardInfo.cardId,
              cardTo: friendCards[0].cardId,
              status: 'sended',
              value: value.toString(),
            ),
          ),
        );
      }
    }
    setState(() {
      value = 0;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: const Text(
        'Sending money',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
      ),
    );
  }

  DropdownMenuItem<CreditCardItem> buildMenuItem(CreditCardItem? item) {
    return DropdownMenuItem(
      value: item,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/mastercard.png', width: 35, height: 35),
          Text(item != null ? '\$${item.cardInfo.value}' : '',
              style: AppTextStyles.cardValueBlack),
          Row(
            children: [
              Text('*${item!.cardInfo.cardNumber.substring(14)}',
                  style: AppTextStyles.regularLowValueGrey),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget _userCards() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Center(
        child: BlocBuilder<CardsBloc, CardsState>(
          builder: (context, state) {
            if (state is CardsLoadedState) {
              selectedCard = state.cards.first;
              return DropdownButtonHideUnderline(
                child: DropdownButton<CreditCardItem>(
                  elevation: 0,
                  isExpanded: true,
                  value: selectedCard,
                  items: state.cards.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => selectedCard = value),
                ),
              );
            } else if (state is CardsLoadingState) {
              return const SpinKitWave(color: Colors.deepOrange);
            } else {
              return const Text('Error');
            }
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'USD',
          style: TextStyle(
            color: Colors.grey.withOpacity(0.4),
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  List<Widget> _getFriends(FriendsLoadedState state) {
    List<Widget> friends = [];
    var i = 0;
    for (var friend in state.friends) {
      friends.add(
        Column(
          children: [
            selectedFriend == i
                ? const CircleAvatar(radius: 60, backgroundColor: Colors.white)
                : const CircleAvatar(radius: 40, backgroundColor: Colors.white),
            selectedFriend == i
                ? Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        friend.info.name,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.friendValueBlack,
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      );
      i++;
    }
    return friends;
  }

  Widget _buildBody() {
    return Center(
      child: Container(
        decoration: AppColors.appBackgroundGradientDecoration,
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<FriendsBloc, FriendsState>(
                        builder: (context, state) {
                          if (state is FriendsLoadingState) {
                            return const SpinKitWave(color: Colors.deepOrange);
                          } else if (state is FriendsLoadedState) {
                            return ListWheelScrollViewX(
                              scrollDirection: Axis.horizontal,
                              children: _getFriends(state),
                              squeeze: 0.85,
                              perspective: 0.005,
                              itemExtent: 100,
                              onSelectedItemChanged: (value) =>
                                  setState(() => selectedFriend = value),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 0, bottom: 0),
                      child: Column(
                        children: [
                          ClipShadowPath(
                            shadow: Shadow(
                              offset: const Offset(0, 1),
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10,
                            ),
                            clipper: SettingsCardClipper(),
                            child: Container(
                              height: 80,
                              width: double.infinity,
                              color: Colors.white,
                              child: _userCards(),
                            ),
                          ),
                          ClipShadowPath(
                            shadow: Shadow(
                              offset: const Offset(0, 1),
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                            clipper: SettingsCardClipper(),
                            child: Stack(
                              children: [
                                Container(
                                  height: 80,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: TextFormField(
                                        style: TextStyle(
                                          color: Colors.grey.withOpacity(0.4),
                                          fontWeight: FontWeight.w800,
                                        ),
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.deepOrange,
                                        cursorWidth: 2,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Type something',
                                          hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(0.4),
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ClipPath(
                clipper: TransferMoneyClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DecreaseButton(
                              onTap: _decreaseValue,
                            ),
                            _buildText(),
                            IncreaseButton(
                              onTap: _increaseValue,
                            ),
                          ],
                        ),
                        BlocBuilder<CardsBloc, CardsState>(
                          builder: (context, state) {
                            if (state is CardsLoadedState) {
                              return AnimatedButton(
                                onTap: _transferMoney,
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
