import 'package:dio/dio.dart';
import 'package:giapha/model/ReadData/ModelVanKhan.dart';
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
