import 'package:flutter/material.dart';
import 'package:giapha/screens/services_screen/vankhan/chitiet_vankhan_screen.dart';

class VanKhanItem extends StatelessWidget {
  final String ten;
  final String id;

  const VanKhanItem({required this.ten, required this.id, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChiTietVanKhanScreen(
              id: id,
              title: ten,
            ),
          ),
        );
      },
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 339,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const VerticalDivider(
                  width: 20,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      Text(
                        ten,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(
                  width: 20,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.black,
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
