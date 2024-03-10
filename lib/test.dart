import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final bool active;
  final double size;
  final Color activeColor;
  final Color inactiveColor;

  const Indicator({
    Key? key,
    this.active = false,
    this.size = 8.0,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: active ? activeColor : inactiveColor,
        shape: BoxShape.circle,
      ),
    );
  }
}