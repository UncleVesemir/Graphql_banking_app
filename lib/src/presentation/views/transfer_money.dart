import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/widgets/animated_button.dart';
import 'package:banking/src/presentation/widgets/custom_clip.dart';
import 'package:banking/src/presentation/widgets/custom_list_wheel.dart';
import 'package:banking/src/presentation/widgets/decrease_button.dart';
import 'package:banking/src/presentation/widgets/increase_button.dart';
import 'package:flutter/material.dart';

class MoneyTransferScreen extends StatefulWidget {
  const MoneyTransferScreen({Key? key}) : super(key: key);

  @override
  State<MoneyTransferScreen> createState() => _MoneyTransferScreenState();
}

class _MoneyTransferScreenState extends State<MoneyTransferScreen> {
  double value = 0;

  void _increaseValue() => setState(() => value++);

  void _decreaseValue() => setState(() {
        if (value > 0) value--;
      });

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

  List<Widget> cards = const [
    CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white,
    ),
    CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white,
    ),
    CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white,
    ),
    CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white,
    ),
  ];

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
                      child: ListWheelScrollViewX(
                        scrollDirection: Axis.horizontal,
                        children: cards,
                        squeeze: 0.7,
                        perspective: 0.005,
                        itemExtent: 80,
                        onSelectedItemChanged: (item) {},
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
                    padding: const EdgeInsets.all(38),
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
                        AnimatedButton(
                          onTap: () {
                            print('tapped');
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
