class Data {
  bool success;
  UserData data;
  String token;

  Data({
    required this.success,
    required this.data,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      success: json['success'],
      data: UserData.fromJson(json['data']),
      token: json['token'],
    );
  }
}

class UserData {
  List<User> user;

  UserData({required this.user});

  factory UserData.fromJson(Map<String, dynamic> json) {
    var userList = json['user'] as List<dynamic>;
    List<User> users = userList.map((user) => User.fromJson(user)).toList();

    return UserData(
      user: users,
    );
  }
}

class User {
  String id;
  String username;
  String password;
  String hovaten;
  String namsinh;
  String tuoi;
  String phone;
  String address;
  String? hometown;
  String? avatar;
  String job;
  String role;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.hovaten,
    required this.namsinh,
    required this.tuoi,
    required this.phone,
    required this.address,
    this.hometown,
    this.avatar,
    required this.job,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        username: json['username'],
        password: json['password'],
        hovaten: json['hovaten'],
        namsinh: json['namsinh'],
        tuoi: json['tuoi'],
        phone: json['phone'],
        address: json['address'],
        hometown: json['hometown'],
        job: json['job'],
        role: json['role'],
        avatar: json['avatar']);
  }
}
