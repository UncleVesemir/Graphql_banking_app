import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/blocs/friends/friends_bloc.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/views/friends.dart';
import 'package:banking/src/presentation/views/history.dart';
import 'package:banking/src/presentation/views/settings/settings.dart';
import 'package:banking/src/presentation/widgets/app_bar.dart';
import 'package:banking/src/presentation/widgets/bottom_app_bar.dart';
import 'package:banking/src/presentation/widgets/card/credit_card_item.dart';
import 'package:banking/src/presentation/widgets/card/main_controller.dart';
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
  int? selectedCardIndex;

  GlobalObjectKey<MainItemsControllerState> controllerKey =
      const GlobalObjectKey<MainItemsControllerState>('controller');

  List<CreditCardItem> cards = [];
  String? searchText;

  void _search(String? text) {
    setState(() {
      searchText = text;
    });
    var state = BlocProvider.of<SignInRegisterBloc>(context).state
        as SignInRegisterLoadedState;
    if (text != null) {
      BlocProvider.of<FriendsBloc>(context)
          .add(SearchFriendEvent(text: text, id: state.user.id));
    } else {
      BlocProvider.of<FriendsBloc>(context)
          .add(FetchFriendsEvent(userId: state.user.id));
    }
  }

  int? _getCardState() {
    if (controllerKey.currentState != null) {
      return controllerKey.currentState!.selectedIndex;
    }
  }

  Widget _editButton() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 0.85,
          colors: [
            Colors.white.withOpacity(0.6),
            Colors.black.withOpacity(1),
          ],
        ),
      ),
      child: const Icon(
        Icons.edit,
        color: Colors.white,
        size: 12,
      ),
    );
  }

  Widget _deleteButton() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 0.85,
          colors: [
            Colors.white.withOpacity(0.6),
            Colors.black.withOpacity(1),
          ],
        ),
      ),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 12,
      ),
    );
  }

  Widget _buildCardsInfo() {
    return Expanded(
      flex: 1,
      child: ClipShadowPath(
        shadow: Shadow(
          offset: const Offset(0, 0),
          color: Colors.grey.withOpacity(0.0),
          blurRadius: 10,
        ),
        clipper: TabClipper(),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CardsBloc, CardsState>(
                builder: (context, state) {
                  if (state is CardsLoadedState) {
                    if (selectedCardIndex != null) {
                      return Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Balance: ',
                                        style: AppTextStyles.loginGrey,
                                      ),
                                      Text(
                                        '\$${state.cards[selectedCardIndex!].value}',
                                        style: AppTextStyles.cardValueBlack,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Card number: ',
                                        style: AppTextStyles.loginGrey,
                                      ),
                                      Text(
                                        '*${state.cards[selectedCardIndex!].number.substring(15)}',
                                        style: AppTextStyles.cardValueBlack,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _editButton(),
                                  const SizedBox(width: 10),
                                  _deleteButton(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateState(int index) {
    setState(() {
      selectedCardIndex = index;
    });
  }

  Widget _userCards() {
    return Flexible(
      flex: 4,
      child: ClipPath(
        clipper: SheetClipper(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white.withOpacity(0.7),
          child: BlocBuilder<CardsBloc, CardsState>(
            builder: (context, state) {
              if (state is CardsLoadedState) {
                return MainItemsController(
                  key: controllerKey,
                  cards: state.cards,
                  onSelected: (index) => _updateState(index),
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
    return SafeArea(
      bottom: false,
      child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCardsInfo(),
                        _userCards(),
                      ],
                    )
                  : _selectedIndex == 1
                      ? FriendsPage(searchText: searchText)
                      : _selectedIndex == 2
                          ? const SettingsPage()
                          : const HistoryPage(),
            ),
            CustomBottomBar(
              onSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardsBloc, CardsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: CustomAppBar(
              index: _selectedIndex,
              onSearch: (text) => _search(text),
            ),
          ),
          body: _buildBody(state),
        );
      },
    );
  }
}
