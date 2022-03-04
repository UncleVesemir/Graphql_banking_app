import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final Function() onTap;
  const AnimatedButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? animation;

  double startWidth = 100.0;
  double startHeight = 100.0;

  @override
  void initState() {
    super.initState();
    animationController ??= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 1,
      lowerBound: 0.7,
      upperBound: 1,
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
    animationController?.forward();
  }

  void onTapUp(TapUpDetails details) {
    animationController?.forward();
    widget.onTap();
  }

  void onTapDown(TapDownDetails details) {
    animationController?.animateBack(0.4);
  }

  @override
  Widget build(BuildContext context) {
    var animationValue = animationController?.value ?? 1;
    return Container(
      width: startWidth * animationValue,
      height: startHeight * animationValue,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            spreadRadius: 11,
            color: Colors.deepOrange.withOpacity(0.65),
            offset: const Offset(15, 15),
            blurRadius: 35,
          )
        ],
      ),
      child: GestureDetector(
        onTapCancel: onTapCancel,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 0.85,
              colors: [
                Colors.yellowAccent.withOpacity(0.6),
                Colors.deepOrange.withOpacity(animationValue),
              ],
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.white,
            size: 35 * animationValue,
          ),
        ),
      ),
    );
  }
}
