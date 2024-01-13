import 'package:flutter/material.dart';
import 'package:giapha/model/EventVO.dart';
// import 'package:lichvannien/utils/date_utils.dart';
// import 'package:lichvannien/utils/lunar_solar_utils.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.event});

  final EventVO event;

  @override
  Widget build(BuildContext context) {
    var title = '${event.date.day}';
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          width: 331,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 3),
                  blurRadius: 7,
                  spreadRadius: 5,
                ),
              ],
              color: const Color(0xffFCCDB3),
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              border: Border.all(color: Colors.white, width: 0.3)),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.red,
                ),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: Text(
                  event.event,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
