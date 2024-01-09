import 'package:dio/dio.dart';
import 'package:giapha/model/diachi_model.dart';

class AddressApi {
  final Dio _dio = Dio();

  Future<List<Province>> fetchProvinces() async {
    final response =
        await _dio.get('https://provinces.open-api.vn/api/?depth=3');

    if (response.statusCode == 200) {
      final List<dynamic> provincesJson = response.data;
      final List<Province> provinces =
          provincesJson.map((json) => Province.fromJson(json)).toList();
      return provinces;
    } else {
      throw Exception('Failed to load provinces');
    }
  }
}
