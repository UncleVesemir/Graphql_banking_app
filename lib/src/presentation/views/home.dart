import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/views/history.dart';
import 'package:banking/src/presentation/views/settings/settings.dart';
import 'package:banking/src/presentation/widgets/bottom_app_bar.dart';
import 'package:banking/src/presentation/widgets/card/add_credit_card.dart';
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

  void _showCardDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddCardDialog();
      },
    );
  }

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
      leading: null,
      automaticallyImplyLeading: false,
      actions: _selectedIndex == 0
          ? [
              Row(
                children: [
                  GestureDetector(
                    onTap: _showCardDialog,
                    child: Container(
                      height: 30,
                      width: 30,
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

class AddCardDialog extends StatefulWidget {
  const AddCardDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AddCardDialog> createState() => _AddCardDialogState();
}

class _AddCardDialogState extends State<AddCardDialog> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
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
          ),
        ),
      ],
      content: AddCreditCardItem(
        width: 350,
        height: 240,
        gradient: AppColors.appBackgroundGradient,
        onChecked: (value) {
          setState(() {
            _checked = value;
          });
        },
      ),
    );
  }
}
