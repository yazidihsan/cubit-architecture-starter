import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex('#26316C');
  static Color secondary = HexColor.fromHex('#FF0000');
  static Color secondary300 = HexColor.fromHex('#F0F2F9');

  static Color failFlushbar = HexColor.fromHex('#E74C3C');
  static Color successFlushbar = HexColor.fromHex('#4CAF50');
  static Color blackColor = HexColor.fromHex('#120D26');
  static Color blackBold = HexColor.fromHex('#000000');
  static Color blackSecondary = HexColor.fromHex('#212433');

  static Color grey300 = HexColor.fromHex("#B6B7BC");
  static Color grey200 = HexColor.fromHex("#CECFD2");
  static Color grey400 = HexColor.fromHex("#9E9FA5");
  static Color grey600 = HexColor.fromHex("#86878F");

  static Color primary900 = HexColor.fromHex("#1E2758");

  static Color white = HexColor.fromHex("#FFFFFF");

  // static Color darkGrey = HexColor.fromHex('#7A7A7A');
  // static Color grey = HexColor.fromHex('#E7E7E7');
  // static Color revision = HexColor.fromHex('#FFC107');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    }

    return Color(int.parse(hexColorString, radix: 16));
  }
}
