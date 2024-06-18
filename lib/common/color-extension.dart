import 'package:flutter/material.dart';

class TColor {
  static Color get primary => const Color(0xff343431);

  static Color get secondary => const Color(0xffb3b3b3);

  static Color get primaryText => const Color(0xff4b4b4b);

  static Color get primaryTextW => const Color(0xfff3f3ff);

  static Color get secondaryText => const Color(0xff878787);

  static Color get placeholder => const Color(0xffc8c8c8);

  static Color get lightGray => const Color(0xffDADEE3);

  static Color get bg => const Color(0xffffffff);
}

extension HexColor on Color {
  static Color formHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension AppContext on BuildContext {
  Size get size => MediaQuery.sizeOf(this);

  double get width => size.width;

  double get height => size.height;
}
