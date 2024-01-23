class NotificationModel {
  final String id;
  final String title;
  final String content;
  final String userId;
  final String date;
  final String baivietId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.date,
    required this.baivietId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      userId: json['userId'] ?? '',
      date: json['date'] ?? '',
      baivietId: json['baivietId'] ?? '',
    );
  }
}
