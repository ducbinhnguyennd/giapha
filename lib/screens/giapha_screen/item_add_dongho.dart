import 'package:flutter/material.dart';

class ItemAddDongho extends StatelessWidget {
  final String? title;
   ItemAddDongho({super.key, this.title });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: Column(children: [],),
    );
  }
}