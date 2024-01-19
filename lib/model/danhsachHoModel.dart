class danhsachHoModel {
  final String id;
  final String name;
  final String key;
  final String address;
  final int members;
  final int generation;
  final String creater;
  final String phone;

  danhsachHoModel({
    required this.id,
    required this.name,
    required this.key,
    required this.address,
    required this.members,
    required this.generation,
    required this.creater,
    required this.phone,
  });

  factory danhsachHoModel.fromJson(Map<String, dynamic> json) {
    return danhsachHoModel(
        id: json['_id'] ?? "",
        name: json['name'] ?? "",
        key: json['key'] ?? "",
        address: json['address'] ?? "",
        members: json['members'] ?? 0,
        generation: json['generation'] ?? 0,
        creater: json['creator']['name'] ?? "",
        phone: json['creator']['phone'] ?? "");
  }
}
