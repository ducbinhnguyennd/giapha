import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ItemHo extends StatelessWidget {
  const ItemHo({super.key, required this.tenho, required this.diachi});
  final String tenho;
  final String diachi;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.red),
        child: Column(
          children: [
            Text(tenho),
            Text(diachi),
          ],
        ),
      ),
    );
  }
}
