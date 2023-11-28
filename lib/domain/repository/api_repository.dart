import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show Response;

import '../../data/helper/api_helper.dart';
import '../../data/helper/image_helper.dart';

class ApiRepository {
  Future<File?> resultImage(String url, String id) async {
    try {
      final Response response = await ApiHelper.get(
        url,
        printResponse: false,
      );
      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        return await ImageHelper.createStoredImage(id, bytes);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("=====>  ERROR ::::  $e");
      return null;
    }
  }
}
