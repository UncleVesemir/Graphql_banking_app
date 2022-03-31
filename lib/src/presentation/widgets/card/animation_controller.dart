abstract class CardAnimationController {
  const CardAnimationController();

  void animateBottomToMiddle() {}
  void animateMiddleToBottom() {}
  void animateMiddleToTop() {}
  void animateTopToMiddle() {}
}

abstract class ItemsController {
  const ItemsController();

  void next() {}
  void previous() {}
}
