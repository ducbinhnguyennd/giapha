import 'package:flutter/material.dart';
import 'package:giapha/model/EventVO.dart';

import 'EventItem.dart';

class EventList extends StatelessWidget {
  const EventList({super.key, required this.data});
  final List<EventVO> data;

  Widget renderItem(EventVO event) {
    return EventItem(event: event);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, int index) {
        return renderItem(data[index]);
      },
    );
  }
}
