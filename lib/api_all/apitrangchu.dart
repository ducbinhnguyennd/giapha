import 'package:dio/dio.dart';
import 'package:giapha/model/EventVO.dart';
import 'package:giapha/model/ReadData/ModelGiaiMong.dart';
import 'package:giapha/model/ReadData/ModelVanKhan.dart';
import 'package:giapha/model/ReadData/ModelXinXam.dart';
import 'package:giapha/model/bangtin_model.dart';
import 'package:giapha/model/chitietUser_model.dart';
import 'package:giapha/model/danhsachHoModel.dart';
import 'package:giapha/model/thongbao_model.dart';
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

class Joindongho {
  Future<Response?> joinDongho(
      String iddongho, String iduser, String key) async {
    print('tan response: $key');
    print('tan response: $iddongho');

    print('tan response: $iduser');

    try {
      var response = await dio.post(
        '$urlapi/joindongho/$iddongho/$iduser',
        data: {"key": key},
      );
      print('dongho ${response}');
      return response;
    } catch (e) {
      print('lỗi nặng ${e.toString()}');
    }
    return null;
  }
}

class PostDongHo {
  Future<Response?> postNewFamily(
      String userId, String name, String address, String key) async {
    try {
      var response = await dio.post('$urlapi/postdongho/$userId',
          data: {'name': name, 'address': address, 'key': key});
      return response;
    } catch (e) {
      print(
          'Error in postNewFamily: ${e.toString()}'); // In lỗi ra console để gỡ lỗi
      throw Exception('Failed to create family: ${e.toString()}');
    }
  }

  Future<Response?> postFirstMember(
      String idDongHo,
      String name,
      String nickName,
      //String username,
      String sex,
      String date,
      String avatar,
      String maritalstatus,
      String phone,
      String academylevel,
      String job,
      String address,
      String hometown,
      String bio,
      bool dead,
      String deaddate,
      String worshipaddress,
      String worshipperson,
      String burialaddress) async {
    try {
      var response = await dio.post('$urlapi/addmember/$idDongHo', data: {
        'name': name,
        'nickname': nickName,
        //'username': username,
        'sex': sex,
        'date': date,
        'avatar': avatar,
        'maritalstatus': maritalstatus,
        'phone': phone,
        'acaddemylevel': academylevel,
        'job': job,
        'address': address,
        'hometown': hometown,
        'bio': bio,
        'dead': dead,
        'deaddate': deaddate,
        'worshipaddress': worshipaddress,
        'worshipperson': worshipperson,
        'burialaddress': burialaddress
      });
      return response;
    } catch (e) {
      throw Exception(e);
    }
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

// xin xăm tổng
class ApiLoaiXinXam {
  Future<List<ItemModelLoaiXam>> fetchLoaiXam() async {
    try {
      final response = await dio.get('$urlapi/getfullxam');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((xinxamJson) => ItemModelLoaiXam.fromJson(xinxamJson))
            .toList();
      } else {
        throw Exception('Failed to load xin xam');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

// chi tiết xin xăm
class ApiChiTietXinXam {
  Future<List<ItemModelXinXam>> fetchxinxamitem(String idxinxamitem) async {
    try {
      final response = await dio.get('$urlapi/getqueboi/$idxinxamitem');
      List<ItemModelXinXam> tattoos = [];

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        for (var json in data) {
          tattoos.add(ItemModelXinXam.fromJson(json));
        }
        print('API xin xăm status1: ${tattoos}');
      }
      return tattoos;
    } catch (e) {
      throw Exception('Error: $e');
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
  Future<List<EventVO>> loadEventData() async {
    try {
      final response = await dio.get('https://appgiapha.vercel.app/getevents');

      if (response.statusCode == 200) {
        List<EventVO> results = [];
        List<dynamic> jsonData = response.data;

        for (var element in jsonData) {
          String dateString = element['date'];
          String name = element['name'];
          var dateArr = dateString.split("/");
          var date =
              DateTime(1993, int.parse(dateArr[1]), int.parse(dateArr[0]));
          EventVO event = EventVO(date: date, event: name);

          results.add(event);
        }

        return results;
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

// giải mộng
class ApiGiaiMong {
  Future<List<ItemModelGiaiMong>> fetchDreams() async {
    try {
      final response = await dio.get('$urlapi/dreams');

      if (response.statusCode == 200) {
        List<ItemModelGiaiMong> dreams = [];

        for (var dreamJson in response.data) {
          dreams.add(ItemModelGiaiMong.fromJson(dreamJson));
        }

        return dreams;
      } else {
        throw Exception('Failed to load dreams');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

// đã log
class ApiBangTinDaLog {
  Future<List<Bangtin>> getPosts(String userId) async {
    try {
      Response response = await dio.get("$urlapi/getbaiviet/$userId");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Bangtin> posts =
            data.map((json) => Bangtin.fromJson(json)).toList();

        return posts;
      } else {
        throw Exception("Failed to load posts");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}

//post bài đăng
class ApiPostBaiDang {
  Future<Response> postBaiViet(String userId, String content) async {
    try {
      return await dio.post(
        '$urlapi/postbaiviet/$userId',
        data: {'content': content},
      );
    } catch (error) {
      throw error;
    }
  }
}

// thông báo
class NotificationApi {
  Future<List<NotificationModel>> getNotifications(String userId) async {
    try {
      final response = await dio.get('$urlapi/notifybaiviet/$userId');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

// xoa bài viết
class XoaBaiDang {
  static Future<void> xoaBaiDang(String userId, String baivietId) async {
    try {
      final response = await dio.delete(
        '$urlapi/deletebaiviet/$userId/$baivietId',
      );
      if (response.statusCode == 200) {
        print('binh xóa ${response.data}');
      } else {
        print('Loi cmnr');
      }
    } catch (e) {
      // Handle Dio exception
      print('Error: $e');
    }
  }
}

// like bài viết
class LikeApiService {
  Future<void> likeBaiViet(String userId, String baiVietId) async {
    try {
      await dio.post(
        '$urlapi/addfavoritebaiviet/$userId/$baiVietId',
      );
    } catch (error) {
      throw error;
    }
  }
}

// post cmt bài đăng
class ApiSCommentBaiDang {
  Future<void> postComment(
      String baivietId, String userId, String comment) async {
    try {
      final response = await dio.post(
        '$urlapi/postcmtbaiviet/$baivietId/$userId',
        data: {'comment': comment},
      );
      print('Response from postComment API: $response');
    } catch (error) {
      print('Error in postComment API: $error');
    }
  }
}

class ApiCmtBaiViet {
  Future<List<Comment>> getComments(String baivietId) async {
    try {
      Response response = await dio.get("$urlapi/getcmtbaiviet/$baivietId");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Comment> posts =
            data.map((json) => Comment.fromJson(json)).toList();
        return posts;
      } else {
        throw Exception("Failed to load posts");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}

// xoa cmt bài viết
class XoaCommentBaiDang {
  static Future<void> xoaComment(
      String baivietId, String commentId, String userId) async {
    try {
      final response = await dio.delete(
        '$urlapi/deletecmtbaiviet/$baivietId/$commentId/$userId',
      );
      if (response.statusCode == 200) {
        print('binh xoa ${response.data}');
      } else {
        print('Loi cmnr');
      }
    } catch (e) {
      // Handle Dio exception
      print('Error: $e');
    }
  }
}

//API cây gia phả
class CayGiaPhaApi {
  Future<Map<String, dynamic>> fetchFamilyTree(String id) async {
    try {
      print('looo $urlapi/familyTree/$id');
      Response response = await dio.get(
        '$urlapi/familyTree/$id',
      );
      if (response.statusCode == 200) {
        print('cây api $response');
        return response.data;
      } else {
        throw Exception("Failed to load family tree");
      }
    } catch (e) {
      throw Exception("Failed to load family tree: $e");
    }
  }
}

// api chi tiết person
class ApiChitietPerson {
  Future<ChitietPerson> fetchPersonData(String id) async {
    try {
      final response = await dio.get('$urlapi/getmember/$id');
      if (response.statusCode == 200) {
        return ChitietPerson.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
