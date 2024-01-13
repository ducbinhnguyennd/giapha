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
  final String icon;
  final String ten;
  final String loai;
  final String check;
  ItemLoai({
    required this.icon,
    required this.ten,
    required this.loai,
    required this.check,
  });
}
