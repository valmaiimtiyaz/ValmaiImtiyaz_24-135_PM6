import 'package:flutter/material.dart';

class Responsive {
  static const double _baseWidth = 390;
  static const double maxContentWidth = 640;

  final double width;
  final double height;

  const Responsive._(this.width, this.height);

  factory Responsive.of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Responsive._(size.width, size.height);
  }

  bool get isLandscape => width > height;
  bool get isTablet => width >= 600;
  double get scale => (width / _baseWidth).clamp(0.85, 1.25).toDouble();
  double s(double base) => base * scale;
  double font(double base) => base * scale;
  double wp(double percent) => width * percent / 100;
  double hp(double percent) => height * percent / 100;

  EdgeInsets all(double base) => EdgeInsets.all(s(base));

  EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: s(horizontal), vertical: s(vertical));
}
