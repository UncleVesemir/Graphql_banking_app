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
import 'package:banking/src/presentation/widgets/card/credit_card_widget.dart';
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
  String? searchText;

  void _onCardSelected(int? item) {
    setState(() {
      _selectedCardIndex = item;
    });
  }

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

  Widget _buildCardsInfo() {
    return Flexible(
      flex: 2,
      child: ClipShadowPath(
        shadow: Shadow(
          offset: const Offset(0, 0),
          color: Colors.grey.withOpacity(0.0),
          blurRadius: 10,
        ),
        clipper: TabClipper(),
        child: Container(
          color: Colors.white,
        ),
      ),
    );
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
