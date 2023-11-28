import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/helper/image_helper.dart';
import '../../utils/app_text.dart';

class ImageRepository {
  Future<File?> pickImage({
    required Function(String) error,
  }) async {
    try {
      return await ImageHelper.imageProcess(error: error);
    } catch (e) {
      debugPrint("=========>  CATCH ERROR :::: $e");
      error(AppText.somethingWentWrong);
      return null;
    }
  }

  Future<void> deletePickedImages() async {
    try {
      await ImageHelper.deletePickedImages();
    } catch (e) {
      debugPrint("=========>  CATCH ERROR :::: $e");
    }
  }
}
