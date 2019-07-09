import 'package:flutter/material.dart';

class Utils {
  double screenAwareSize(double size, BuildContext context) {
    final double baseHeight = MediaQuery.of(context).size.height;
    return size * MediaQuery.of(context).size.height / baseHeight;
  }
}
