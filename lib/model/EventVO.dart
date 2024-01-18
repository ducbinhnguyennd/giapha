class EventVO {
  String? id;
  String? event;
  DateTime? date;

  EventVO({
    this.id,
    this.event,
    this.date,
  });

  factory EventVO.fromJson(Map<String, dynamic> json) {
    return EventVO(
      id: json['_id'],
      event: json['name'],
      date: json['date'],
    );
  }
}
