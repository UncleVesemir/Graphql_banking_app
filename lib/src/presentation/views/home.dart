import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/views/history.dart';
import 'package:banking/src/presentation/views/settings/settings.dart';
import 'package:banking/src/presentation/widgets/bottom_app_bar.dart';
import 'package:banking/src/presentation/widgets/card_widget.dart';
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

  Widget _homeSheet(ScrollController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 18, left: 10, right: 10),
      child: Column(
        children: [
          const Text(
            'Transactions',
            style: AppTextStyles.boldMediumValue,
          ),
          const SizedBox(height: 15),
          SizedBox(
            child: ListView.builder(
              controller: controller,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext ctx, int counter) {
                return const TransactionItem();
              },
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildSheet() {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        return true;
      },
      child: DraggableScrollableSheet(
        minChildSize: 0.4,
        initialChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (BuildContext context, ScrollController controller) {
          return ClipPath(
            clipper: SheetClipper(),
            child: Container(
              color: Colors.white,
              child: MediaQuery.removePadding(
                context: context,
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  controller: controller,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 170.0, right: 170),
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    _homeSheet(controller),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: AppColors.appBackgroundGradient,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: AppColors.appBackgroundGradient,
            child: _selectedIndex == 0
                ? Column(
                    children: [
                      const SizedBox(height: 90),
                      Expanded(flex: 2, child: CardWidget()),
                      const Spacer(flex: 2),
                    ],
                  )
                : _selectedIndex == 3
                    ? const HistoryPage()
                    : const SettingsPage(),
          ),
          _selectedIndex == 0 ? _buildSheet() : Container(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
}
