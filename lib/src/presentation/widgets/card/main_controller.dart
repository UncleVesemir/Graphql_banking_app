import 'package:banking/src/domain/entities/card.dart' as card;
import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/widgets/card/animation_controller.dart';
import 'package:banking/src/presentation/widgets/card/credit_card_item.dart';
import 'package:banking/src/presentation/widgets/card/credit_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum Position { bottom, middle, top }

class CardAnimation extends StatefulWidget {
  final double offset;
  final card.Card info;
  final int index;
  final Function(int index) onUpdate;
  final Function(Key key) onTop;
  final Function(Key key) onBottom;
  const CardAnimation({
    required this.info,
    required this.index,
    required this.offset,
    required this.onUpdate,
    required this.onTop,
    required this.onBottom,
    required Key key,
  }) : super(key: key);

  @override
  State<CardAnimation> createState() => _CardAnimationState();
}

class _CardAnimationState extends State<CardAnimation>
    with SingleTickerProviderStateMixin
    implements CardAnimationController {
  Position position = Position.bottom;

  double perspectiveStart = -0.002;
  double perspectiveEnd = 0.000;

  double yStart = 0.3;
  double yEnd = 1.0;

  double xStart = 50;
  double xCenter = -140;
  double xEnd = -280;

  double zStart = 1;
  double zCenter = 0.9;
  double zEnd = 1.3;

  double animationStart = 1.0;
  double animationCenter = 2.0;
  double animationEnd = 3.0;

  double controllerStart = 0.0;
  double controllerCenter = 0.5;
  double controllerEnd = 1.0;

  List<double>? x;
  List<double>? fx;
  List<double>? fy;
  List<double>? fz;
  List<double>? fp;

  AnimationController? animationController;
  Animation? animation;

  @override
  void initState() {
    super.initState();

    x = [animationStart, animationCenter, animationEnd];
    fx = [xStart, xCenter, xEnd];
    fy = [yStart, yEnd, yEnd];
    fz = [zStart, zCenter, zEnd];
    fp = [perspectiveStart, perspectiveEnd, perspectiveEnd];

    animationController ??= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    animation = Tween(begin: animationStart, end: animationEnd)
        .animate(animationController!);

    animationController?.addListener(() {
      if (animation != null) {
        if (animation!.value >= 1.1 && animation!.value <= 2) {
          print('onUpdate');
          widget.onUpdate(widget.index);
        }
      }
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  double L(double xc, List<double> x, List<double> y) {
    int n = x.length;
    double top;
    double bottom;
    int k;
    double R = 0;
    for (int i = 0; i < n; i++) {
      top = 1;
      bottom = 1;
      for (k = 0; k < n; k++) {
        if (k == i) continue;
        top *= xc - x[k];
      }
      for (k = 0; k < n; k++) {
        if (x[i] == x[k]) continue;
        bottom *= x[i] - x[k];
      }
      R += y[i] * top / bottom;
    }
    return R;
  }

  @override
  void animateBottomToMiddle() {
    print('bottom -> middle');
    setState(() => position = Position.middle);
    animationController?.animateTo(controllerCenter);
  }

  @override
  void animateMiddleToBottom() {
    print('middle -> bottom');
    setState(() => position = Position.bottom);
    animationController?.reverse();
  }

  @override
  void animateMiddleToTop() {
    print('middle -> top');
    setState(() => position = Position.top);
    animationController?.forward();
  }

  @override
  void animateTopToMiddle() {
    print('top -> middle');
    setState(() => position = Position.middle);
    animationController?.animateTo(controllerCenter);
  }

  double _calcX() {
    double? t = animation?.value;
    t ??= 1;
    return L(t, x!, fx!);
  }

  double _calcY() {
    double? t = animation?.value;
    t ??= 1;
    if (t >= 2) return 1;
    return L(t, x!, fy!);
  }

  double _calcZ() {
    double? t = animation?.value;
    t ??= 1;
    return L(t, x!, fz!);
  }

  double _calcP() {
    double? t = animation?.value;
    t ??= 1;
    if (t >= 2) return 0;
    return L(t, x!, fp!);
  }

  double _calcShadow() {
    double? t = animation?.value;
    t ??= 1;
    return -32 * t * t + 128 * t - 88;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100 + widget.offset,
      left: MediaQuery.of(context).size.width / 2 - 300 / 2,
      child: AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, _) {
          return Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4(
              //
              1, 0, 0, 0,
              0, _calcY(), 0, _calcP(),
              0, 0, 1, 0,
              0, _calcX(), 0, _calcZ(),
            ),
            child: SizedBox(
              height: 220,
              width: 300,
              child: CreditCardItem(
                cardInfo: CreditCardModel(
                  height: 100,
                  width: 100,
                  gradient: AppColors.appBackgroundGradient,
                  info: widget.info,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MainItemsController extends StatefulWidget {
  final List<card.Card> cards;
  final Function(int index) onSelected;
  const MainItemsController({
    required this.onSelected,
    required this.cards,
    Key? key,
  }) : super(key: key);

  @override
  State<MainItemsController> createState() => _MainItemsControllerState();
}

class _MainItemsControllerState extends State<MainItemsController>
    implements ItemsController {
  List<GlobalObjectKey<_CardAnimationState>> keys = [];
  List<CardAnimation> cards = [];

  double direction = 0.0;
  int sensitivity = 5;

  GlobalObjectKey<_CardAnimationState>? selectedCard;
  int? selectedIndex;

  void _checkIndex() {
    if (selectedCard == null) {
      setState(() {
        selectedCard = keys.last;
        selectedIndex = keys.length - 1;
      });
    }
  }

  @override
  void next() {
    _checkIndex();
    if (selectedCard!.currentState!.position == Position.bottom) {
      selectedCard!.currentState!.animateBottomToMiddle();
      widget.onSelected(selectedIndex!);
      return;
    }
    if (selectedCard!.currentState!.position == Position.middle) {
      if (selectedIndex != 0) {
        selectedCard!.currentState!.animateMiddleToTop();
        keys[selectedIndex! - 1].currentState!.animateBottomToMiddle();
        setState(() {
          selectedIndex = selectedIndex! - 1;
          selectedCard = keys[selectedIndex!];
        });
        widget.onSelected(selectedIndex!);
      }
    }
  }

  @override
  void previous() {
    _checkIndex();
    if (selectedCard!.currentState!.position == Position.middle) {
      if (selectedIndex! != keys.length - 1) {
        selectedCard!.currentState!.animateMiddleToBottom();
        keys[selectedIndex! + 1].currentState!.animateTopToMiddle();
        setState(() {
          selectedIndex = selectedIndex! + 1;
          selectedCard = keys[selectedIndex!];
        });
        widget.onSelected(selectedIndex!);
      }
    }
  }

  void _onUpdate(int index) {
    setState(() {
      final elIndex = cards.indexWhere((element) => element.index == index);
      if (elIndex != cards.length - 1) {
        cards.insert(cards.length - 1, cards.removeAt(elIndex));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initCards();
  }

  @override
  void didUpdateWidget(MainItemsController oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initCards();
  }

  void _initCards() {
    keys = [];
    cards = [];
    for (var i = 0; i < widget.cards.length; i++) {
      keys.add(GlobalObjectKey(i));
    }
    for (var i = 0; i < widget.cards.length; i++) {
      cards.add(
        CardAnimation(
          index: i,
          key: keys[i],
          info: widget.cards[i],
          offset: i * 10,
          onUpdate: (index) => _onUpdate(index),
          onBottom: (key) => previous(),
          onTop: (key) => next(),
        ),
      );
    }
    selectedCard = keys.last;
    selectedIndex = keys.length - 1;
  }

  void _updateDiraction(DragUpdateDetails details) {
    if (details.delta.dy > sensitivity) {
      setState(() {
        direction = details.delta.dy;
      });
    } else if (details.delta.dy < -sensitivity) {
      setState(() {
        direction = details.delta.dy;
      });
    }
  }

  void _determineDirection(DragEndDetails details) {
    if (direction > sensitivity) previous();
    if (direction < -sensitivity) next();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: GestureDetector(
            onVerticalDragUpdate: _updateDiraction,
            onVerticalDragEnd: _determineDirection,
            child: BlocBuilder<CardsBloc, CardsState>(
              builder: (context, state) {
                if (state is CardsLoadedState) {
                  return Stack(
                    children: cards,
                  );
                } else if (state is CardsLoadedState) {
                  return const SpinKitWave(
                    color: Colors.deepOrange,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
