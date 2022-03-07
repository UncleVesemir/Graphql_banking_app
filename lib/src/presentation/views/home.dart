import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: AppColors.appBackgroundGradient,
          child: Column(
            children: [
              const SizedBox(height: 90),
              Expanded(flex: 2, child: CardWidget()),
              const Spacer(flex: 2),
            ],
          ),
        ),
        _buildSheet(),
        CustomAppBar(
          onSelected: (index) {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
}
