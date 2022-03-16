import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/widgets/animated_button.dart';
import 'package:banking/src/presentation/widgets/custom_clip.dart';
import 'package:banking/src/presentation/widgets/custom_list_wheel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class MoneyTransferScreen extends StatefulWidget {
  const MoneyTransferScreen({Key? key}) : super(key: key);

  @override
  State<MoneyTransferScreen> createState() => _MoneyTransferScreenState();
}

class _MoneyTransferScreenState extends State<MoneyTransferScreen> {
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
        const Text(
          '20',
          style: TextStyle(
            color: Colors.black,
            fontSize: 50,
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
                clipper: SheetClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(38),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DecreaseButton(),
                            _buildText(),
                            IncreaseButton(),
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

class IncreaseButton extends StatefulWidget {
  const IncreaseButton({
    Key? key,
  }) : super(key: key);

  @override
  State<IncreaseButton> createState() => _IncreaseButtonState();
}

class _IncreaseButtonState extends State<IncreaseButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform(
            transform: Matrix4.skewY(0.1),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(24),
              ),
              height: 130,
              width: 80,
            ),
          ),
          const Icon(Icons.add, size: 35),
        ],
      ),
    );
  }
}

class DecreaseButton extends StatelessWidget {
  const DecreaseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform(
          transform: Matrix4.skewY(-0.1),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.4),
                  width: 3,
                )),
            height: 130,
            width: 80,
          ),
        ),
        const Icon(Icons.remove, size: 35),
      ],
    );
  }
}
