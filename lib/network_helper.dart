import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);
  Future<dynamic> getExchangeRate() async {
    dynamic data;
    try {
      http.Response res = await http.get(url);
      if (res.statusCode >= 200 && res.statusCode <= 299) {
        data = jsonDecode(res.body);
      } else {
        throw 'Unable to get json data';
      }
    } catch (e) {
      print(e);
    }
    return data;
  }
}
