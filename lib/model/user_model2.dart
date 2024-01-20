class UserModel {
  String id;
  String username;
  String hovaten;
  String namsinh;
  String tuoi;
  String phone;
  String address;
  String? hometown;
  String? avatar;
  String job;
  String role;
  String? lineage;

  UserModel(
      {required this.id,
      required this.username,
      required this.hovaten,
      required this.namsinh,
      required this.tuoi,
      required this.phone,
      required this.address,
      this.hometown,
      this.avatar,
      required this.job,
      required this.role,
      this.lineage});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['_id'],
        username: json['username'],
        hovaten: json['hovaten'],
        namsinh: json['namsinh'],
        tuoi: json['tuoi'],
        phone: json['phone'],
        avatar: json['avatar'],
        address: json['address'],
        hometown: json['hometown'],
        job: json['job'],
        role: json['role'],
        lineage: json['lineage']);
  }
}
