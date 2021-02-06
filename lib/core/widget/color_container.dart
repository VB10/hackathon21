import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  final Color color;
  final bool isClick;

  const ColorContainer({Key key, this.color, this.isClick}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(height: 100, width: 100, color: isClick ? color : Colors.red);
  }
}
