class ItemModelGiaiMong {
  final String id;
  final String ten;
  final String gioithieu;

  ItemModelGiaiMong({
    required this.id,
    required this.ten,
    required this.gioithieu,
  });

  factory ItemModelGiaiMong.fromJson(Map<String, dynamic> json) {
    return ItemModelGiaiMong(
      id: json['_id'] ?? "",
      ten: json['name'] ?? "",
      gioithieu: json['description'] ?? "",
    );
  }
}
