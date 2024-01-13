import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserServices {
  final _storage = const FlutterSecureStorage();

  Future<void> saveinfologin(dynamic tcm) async {
    return await _storage.write(key: 'user', value: tcm.toString());
  }

  Future<String> getInfoLogin() async {
    String? info = await _storage.read(key: 'user');
    if (info == null) {
      return "";
    } else {
      return info;
    }
  }

  Future<void> deleteinfo() async {
    return await _storage.delete(key: 'user');
  }
}
