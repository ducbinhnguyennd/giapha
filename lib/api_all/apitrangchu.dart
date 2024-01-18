import 'package:dio/dio.dart';
import 'package:giapha/model/EventVO.dart';
import 'package:giapha/model/ReadData/ModelVanKhan.dart';
import 'package:giapha/model/danhsachHoModel.dart';
import 'package:giapha/model/user_model2.dart';

Dio dio = Dio();

String urlapi = 'https://appgiapha.vercel.app';

class Login {
  Future<Response?> signIn(String username, String password) async {
    try {
      var response = await dio.post(
        '$urlapi/login',
        data: {"username": username, "password": password},
      );
      print('API response status: ${response.statusCode}');
      print('API response data: ${response.data}');
      return response;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}

// lay info user
class ApiUser {
  Future<UserModel> fetchUserData(String userId) async {
    final response = await dio.get('$urlapi/user/$userId');
    return UserModel.fromJson(response.data);
  }
}

//xóa user
class XoaUser {
  static Future<void> xoaUser(String userId) async {
    try {
      final response = await dio.delete(
        '$urlapi/deleteUser/$userId',
      );
      if (response.statusCode == 200) {
        print('binh xoa ${response.data}');
      } else {
        print('Loi cmnr');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

// thay đổi pass, username
class PasswordChangeService {
  // Future<void> changePassword(
  //     String userId, String oldPassword, String newPassword) async {
  //   try {
  //     final response = await dio.post(
  //       '$urlapi/repass/$userId',
  //       data: {
  //         'passOld': oldPassword,
  //         'passNew': newPassword,
  //       },
  //     );

  //     if (response.statusCode != 200) {
  //       throw Exception('Đổi mật khẩu thất bại');
  //     }
  //   } catch (error) {
  //     throw Exception('Đã xảy ra lỗi: $error');
  //   }
  // }

  Future<void> changeUsername(String userId, String username, String hovaten,
      String phone, String address, String job) async {
    try {
      final response = await dio.put(
        '$urlapi/updateUser/$userId',
        data: {
          'username': username,
          'hovaten': hovaten,
          'phone': phone,
          'address': address,
          'job': job
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Đổi thành công');
      }
    } catch (error) {
      throw Exception('Đã xảy ra lỗi: $error');
    }
  }
}

// văn khấn tổng
class ApiService {
  Future<List<ItemLoai>> fetchEvents() async {
    try {
      final response = await dio.get('$urlapi/getloaivankhan');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((eventJson) => ItemLoai.fromJson(eventJson)).toList();
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

// văn khấn item
class ApiVanKhanItem {
  Future<List<ItemLoai>> fetchVankhanitem(String idvankhanitem) async {
    try {
      final response = await dio.get('$urlapi/getvankhan/$idvankhanitem');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((eventJson) => ItemLoai.fromJson(eventJson)).toList();
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

// chi tiết văn khấn
class ApiChiTietVanKhan {
  Future<VanKhanModel> fetchVanKhan(String id) async {
    final response = await dio.get('$urlapi/getchitietvankhan/$id');
    if (response.statusCode == 200) {
      return VanKhanModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load VanKhan');
    }
  }
}

// danh sách họ
class DanhSachHoService {
  Future<List<danhsachHoModel>> fetchdsHo() async {
    try {
      final response = await dio.get('$urlapi/getdongho');

      if (response.statusCode == 200) {
        List<danhsachHoModel> users = [];
        for (var userJson in response.data) {
          users.add(danhsachHoModel.fromJson(userJson));
        }
        return users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

// thêm, lấy ds sự kiện
class ApiSukien {
  Future<List<EventVO>> fetchEvents() async {
    try {
      final response = await dio.get('$urlapi/getevents');

      if (response.statusCode == 200) {
        List<EventVO> events = [];
        for (var eventJson in response.data) {
          events.add(EventVO.fromJson(eventJson));
          print('binh su kien $eventJson');
        }

        return events;
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<EventVO> postEvent(String name, String date) async {
    try {
      final response = await dio.post(
        '$urlapi/postevent',
        data: {'name': name, 'date': date},
      );

      if (response.statusCode == 200) {
        return EventVO.fromJson(response.data);
      } else {
        throw Exception('Failed to post event');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Thêm các hàm cập nhật và xóa sự kiện tại đây (putEvent, deleteEvent)
}
