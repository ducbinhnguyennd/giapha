class danhsachHoModel {
  final String id;
  final String name;
  final String key;
  final String address;
  final List<String> user;
  final List<String> userId;
  final List<String> baiviet;

  danhsachHoModel({
    required this.id,
    required this.name,
    required this.key,
    required this.address,
    required this.user,
    required this.userId,
    required this.baiviet,
  });

  factory danhsachHoModel.fromJson(Map<String, dynamic> json) {
    return danhsachHoModel(
      id: json['_id'],
      name: json['name'],
      key: json['key'],
      address: json['address'],
      user: List<String>.from(json['user']),
      userId: List<String>.from(json['userId']),
      baiviet: List<String>.from(json['baiviet']),
    );
  }
}
