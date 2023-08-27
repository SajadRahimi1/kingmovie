import 'package:flutter/material.dart' show Color;

extension DownloadColor on String? {
  Color downloadColor() {
    String? colorString = this;
    switch (colorString) {
      case 'color1':
        return const Color(0xff49461d);
      case 'color2':
        return const Color(0xff440f2d);
      default:
        return const Color(0xff152333);
    }
  }
}
