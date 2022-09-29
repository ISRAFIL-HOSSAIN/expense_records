import 'dart:ui';

class CardDetails{
  static const double kCardHeight = 225;
  static const double kCardWidth = 356;
  static const double kSpaceBetweenCard = 24;
  static const double kSpaceBetweenUnselectCard = 32;
  static const double kSpaceUnselectedCardToTop = 320;
  static Duration kAnimationDuration = const Duration(milliseconds: 245);
}

class CreditCardData {
  CreditCardData({required this.backgroundColor});
  final Color backgroundColor;
}