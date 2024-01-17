class VanKhanModel {
  final String id;
  final String name;
  final String gioiThieu;
  final String samle;
  final String vanKhan;

  VanKhanModel({
    required this.id,
    required this.name,
    required this.gioiThieu,
    required this.samle,
    required this.vanKhan,
  });

  factory VanKhanModel.fromJson(Map<String, dynamic> json) {
    return VanKhanModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      gioiThieu: json['gioithieu'] ?? '',
      samle: json['samle'] ?? '',
      vanKhan: json['vankhan'] ?? '',
    );
  }
}

class ItemLoai {
  final String? id;
  final String? name;

  ItemLoai({this.id, this.name});

  factory ItemLoai.fromJson(Map<String, dynamic> json) {
    return ItemLoai(id: json['id'], name: json['name']);
  }
}
