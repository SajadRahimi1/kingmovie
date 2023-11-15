import 'package:flutter/material.dart' show Color;

extension DownloadColor on String? {
  Color downloadColor() {
    String? title = this;
    if (title?.contains('دوبله') ?? false) return const Color(0xff49461d);
    if (title?.contains('زیرنویس') ?? false) return const Color(0xff440f2d);
    return const Color(0xff152333);
  }

  String removeAllHtmlTags() {
    String htmlText = this ?? "";
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
