import 'package:flutter/material.dart';

class AppStyle {
  static const double mobileWidth = 428;

  static Size size = const Size(0, 0);
  static double bottomPadding = 0;
  static double topPadding = 0;

  static void setupData(MediaQueryData queryData) {
    size = queryData.size;
    bottomPadding = queryData.padding.bottom;
    topPadding = queryData.padding.top;
  }

  static double getSize(double pxSize) {
    return size.width * pxSize / mobileWidth;
  }
}
