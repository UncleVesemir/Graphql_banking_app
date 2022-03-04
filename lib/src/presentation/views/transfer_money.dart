import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/widgets/animated_button.dart';
import 'package:flutter/material.dart';

class MoneyTransferScreen extends StatefulWidget {
  const MoneyTransferScreen({Key? key}) : super(key: key);

  @override
  State<MoneyTransferScreen> createState() => _MoneyTransferScreenState();
}

class _MoneyTransferScreenState extends State<MoneyTransferScreen> {
  Widget _increaseButton() {
    return ClipPath(
      clipper: AddButtonClipper(),
      child: Container(
        height: 130,
        width: 80,
        color: Colors.grey.withOpacity(0.2),
        child: const Icon(Icons.add, size: 35),
      ),
    );
  }

  Widget _decreaseButton() {
    return ClipPath(
      clipper: DecreaseButtonClipper(),
      child: Container(
        height: 130,
        width: 80,
        color: Colors.grey.withOpacity(0.2),
        child: const Icon(Icons.remove, size: 35),
      ),
    );
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
        decoration: AppColors.appBackgroundGradient,
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Container(),
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _decreaseButton(),
                            _buildText(),
                            _increaseButton(),
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

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 50;
    double pi = 3.14;

    double extra = 20;

    Path path = Path()
      ..lineTo(size.width - radius, extra)
      ..arcTo(
          Rect.fromPoints(Offset(size.width - radius, extra),
              Offset(size.width, radius)), // Rect
          1.5 * pi, // Start engle
          0.5 * pi, // Sweep engle
          true) // direction clockwise
      ..lineTo(size.width, size.height - radius)
      ..arcTo(
          Rect.fromCircle(
              center: Offset(size.width - radius, size.height - radius),
              radius: radius),
          0,
          0.5 * pi,
          false)
      ..lineTo(radius, size.height)
      ..arcTo(Rect.fromLTRB(0, size.height - radius, radius, size.height),
          0.5 * pi, 0.5 * pi, false)
      ..lineTo(0, radius)
      ..arcTo(const Rect.fromLTWH(0, 0, 70, 100), 1 * pi, 0.5 * pi, false)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
