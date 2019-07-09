import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../mixins/utils.dart';

class TitleText extends StatelessWidget with Utils {
  final String title;

  TitleText(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: screenAwareSize(36.0, context),
        fontFamily: 'NunitoSans',
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
