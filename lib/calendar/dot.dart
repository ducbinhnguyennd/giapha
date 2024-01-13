import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  const Dot({super.key, required this.isShow, required this.color});
  final bool isShow;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration:
          isShow ? BoxDecoration(color: color, shape: BoxShape.circle) : null,
    );
  }
}
