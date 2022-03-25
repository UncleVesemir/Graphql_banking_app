import 'package:flutter/material.dart';

class IncreaseButton extends StatefulWidget {
  final Function() onTap;
  const IncreaseButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<IncreaseButton> createState() => _IncreaseButtonState();
}

class _IncreaseButtonState extends State<IncreaseButton>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? animation;

  double startElevation = 0.0;
  double endEleveation = 10.0;

  @override
  void initState() {
    super.initState();
    animationController ??= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      lowerBound: 0,
      upperBound: 0.4,
    );
    animation = Tween(begin: 1, end: 2).animate(animationController!);

    animationController?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    animationController = null;
    super.dispose();
  }

  void onTapCancel() {
    animationController?.animateBack(0.0);
  }

  void onTapUp(TapUpDetails details) {
    animationController?.animateBack(0.0);
    widget.onTap();
  }

  void onTapDown(TapDownDetails details) {
    animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapCancel: onTapCancel,
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform(
            transform: Matrix4.skewY(0.1),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(animationController!.value),
                  ),
                ],
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
