class ItemModelXinXam {
  final int id;
  final String ten;
  final String ten1;
  final String noidung;
  final String? loai;
  ItemModelXinXam({
    required this.id,
    required this.ten,
    required this.ten1,
    required this.noidung,
    required this.loai,
  });
}

class ItemModelLoaiXam {
  final String ten;
  final String check;
  ItemModelLoaiXam({
    required this.ten,
    required this.check,
  });
}
