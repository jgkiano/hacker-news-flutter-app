import 'package:flutter/material.dart';

class ItemListSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 5.0,
        bottom: 10.0,
      ),
      child: Center(
        child: Container(
          height: 20.0,
          width: 20.0,
          child: CircularProgressIndicator(
            valueColor:
                new AlwaysStoppedAnimation<Color>(Colors.deepOrange.shade300),
          ),
        ),
      ),
    );
  }
}
