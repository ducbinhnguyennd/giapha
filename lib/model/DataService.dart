import 'dart:async' show Future;
import 'dart:convert';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:giapha/model/EventVO.dart';
import 'package:giapha/model/QuoteVO.dart';

Future<String> loadAssets(name) async {
  return await rootBundle.loadString(name);
}

Dio dio = Dio();
Future<List<EventVO>> loadEventData() async {
  try {
    final response = await dio.get('https://appgiapha.vercel.app/getevents');

    if (response.statusCode == 200) {
      List<EventVO> results = [];
      List<dynamic> jsonData = response.data;
      if (kDebugMode) {
        print(jsonData);
      }
      for (var element in jsonData) {
        String dateString = element['date'];
        String name = element['name'];
        var dateArr = dateString.split("/");
        var date = DateTime(1993, int.parse(dateArr[1]), int.parse(dateArr[0]));

        // Sử dụng { } thay vì ( ) khi khởi tạo đối tượng EventVO
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

Future<List<QuoteVO>> loadQuoteData() async {
  var jsonString = await loadAssets('assets/quotes.json');
  List<QuoteVO> results = [];
  List jsonData = jsonDecode(jsonString);
  jsonData.forEach((element) {
    String content = element['content'];
    String author = element['author'];
    QuoteVO quote = QuoteVO(content, author);
    results.add(quote);
  });
  return results;
}
