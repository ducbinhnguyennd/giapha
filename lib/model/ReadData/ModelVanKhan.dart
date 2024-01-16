class ItemModel {
  final int id;
  final String ten;
  final String gioithieu;
  final String samle;
  final String vankhan;
  final String loai;

  ItemModel(
      {required this.id,
      required this.ten,
      required this.gioithieu,
      required this.samle,
      required this.vankhan,
      required this.loai});
}

class ItemLoai {
  final String id;
  final String name;

  ItemLoai({required this.id, required this.name});

  factory ItemLoai.fromJson(Map<String, dynamic> json) {
    return ItemLoai(id: json['id'], name: json['name']);
  }
}
