import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/views/transfer_money.dart';
import 'package:banking/src/presentation/widgets/custom_clip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class CustomBottomBar extends StatefulWidget {
  final Function(int) onSelected;
  const CustomBottomBar({
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _selected = 0;

  void _onTap(int index) {
    widget.onSelected(index);
    setState(() {
      _selected = index;
    });
  }

  Widget _bottomAppBarItem(String icon, int index) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => _onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: 23,
              height: 23,
              color: index == _selected ? Colors.black : Colors.grey[500],
              image: Svg('assets/images/$icon'),
            ),
            index == _selected
                ? Column(
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(width: 0, height: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipShadowPath(
          shadow: Shadow(
            offset: const Offset(0, 0),
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 20,
          ),
          clipper: FabClipper(),
          child: Container(
            width: 135,
            height: 107,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const MoneyTransferScreen(),
              ),
            );
          },
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 0.85,
                colors: [
                  // Colors.yellowAccent.withOpacity(0.6),
                  // Colors.deepOrange.withOpacity(1),
                  Colors.grey.withOpacity(0.2),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 35),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 10),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      offset: const Offset(0.0, -5.0),
                      blurRadius: 10,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(45),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _bottomAppBarItem('home.svg', 0),
                      _bottomAppBarItem('cards.svg', 1),
                      const Spacer(flex: 2),
                      _bottomAppBarItem('stats.svg', 2),
                      _bottomAppBarItem('security.svg', 3),
                    ],
                  ),
                ),
              ),
              _buildFAB(),
            ],
          ),
        ),
        Container(
          height: 0,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
        ),
      ],
    );
  }
}
