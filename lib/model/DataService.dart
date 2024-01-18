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
