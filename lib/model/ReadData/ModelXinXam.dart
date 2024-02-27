class ItemModelXinXam {
  final String id;
  final String tenque;
  final String tenxam;
  final String noidung;
  ItemModelXinXam({
    required this.id,
    required this.tenque,
    required this.tenxam,
    required this.noidung,
  });
  factory ItemModelXinXam.fromJson(Map<String, dynamic> json) {
    return ItemModelXinXam(
      id: json['id'] ?? '',
      tenque: json['tenque'] ?? '',
      tenxam: json['tenxam'] ?? '',
      noidung: json['noidung'] ?? '',
    );
  }
}

class ItemModelLoaiXam {
  final String ten;
  final String id;
  ItemModelLoaiXam({
    required this.ten,
    required this.id,
  });
  factory ItemModelLoaiXam.fromJson(Map<String, dynamic> json) {
    return ItemModelLoaiXam(id: json['id'], ten: json['name']);
  }
}
