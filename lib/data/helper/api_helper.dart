// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static final http.Client _client = http.Client();

  static Future<http.Response> get(String uri,
      {bool printResponse = true}) async {
    debugPrint("=====> API LOG: GET REQUEST:\n$uri");
    final http.Response response = await _client.get(
      Uri.parse(uri),
    );
    debugPrint(
        "=====> API LOG: GET RESPONSE: ${response.statusCode}\n${printResponse ? response.body : ""}");
    return response;
  }
}
