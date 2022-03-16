import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/views/history.dart';
import 'package:banking/src/presentation/views/settings/settings.dart';
import 'package:banking/src/presentation/widgets/bottom_app_bar.dart';
import 'package:banking/src/presentation/widgets/card/credit_card_item.dart';
import 'package:banking/src/presentation/widgets/card/credit_card_model.dart';
import 'package:banking/src/presentation/widgets/card/credit_card_widget.dart';
import 'package:banking/src/presentation/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSheetExpanded = false;
  int _selectedIndex = 0;

  List<CreditCardItem> cards = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cards.add(
      CreditCardItem(
        // key: UniqueKey(),
        cardInfo: CreditCardModel(
          index: 0,
          height: 170.0,
          width: 280.0,
          cardHolderName: 'ILYA LEBEDZEU',
          expDate: '21/05',
          cardNumber: 1234567898765432,
          gradient: AppColors.appBackgroundGradient,
        ),
      ),
    );
    cards.add(
      CreditCardItem(
        // key: UniqueKey(),
        cardInfo: CreditCardModel(
          index: 1,
          height: 170.0,
          width: 280.0,
          cardHolderName: 'ILYA LEBEDZEU',
          expDate: '21/05',
          cardNumber: 1234567898765432,
          gradient: AppColors.appBackgroundGradient,
        ),
      ),
    );
    cards.add(
      CreditCardItem(
        // key: UniqueKey(),
        cardInfo: CreditCardModel(
          index: 2,
          height: 170.0,
          width: 280.0,
          cardHolderName: 'ILYA LEBEDZEU',
          expDate: '21/05',
          cardNumber: 1234567898765432,
          gradient: AppColors.appBackgroundGradient,
        ),
      ),
    );
    cards.add(
      CreditCardItem(
        // key: UniqueKey(),
        cardInfo: CreditCardModel(
          index: 3,
          height: 170.0,
          width: 280.0,
          cardHolderName: 'ILYA LEBEDZEU',
          expDate: '21/05',
          cardNumber: 1234567898765432,
          gradient: AppColors.appBackgroundGradient,
        ),
      ),
    );
  }

  Widget _buildCardsInfo() {
    return Flexible(
      flex: 2,
      child: Column(),
    );
  }

  Widget _buildCards() {
    return Flexible(
      flex: 6,
      child: ClipPath(
        clipper: SheetClipper(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Flexible(
                child: CreditCards3d(
                  children: cards,
                  onSelected: (item) {},
                ),
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
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
                      _buildCards(),
                    ],
                  )
                : _selectedIndex == 3
                    ? const HistoryPage()
                    : const SettingsPage(),
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

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        _selectedIndex == 0
            ? 'Home'
            : _selectedIndex == 1
                ? 'Friends'
                : _selectedIndex == 2
                    ? 'Settings'
                    : 'History',
        style: AppTextStyles.boldMediumValueBlack,
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
