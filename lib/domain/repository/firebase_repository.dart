import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/helper/firebase_helper.dart';
import '../../data/model/feed_model.dart';
import '../../utils/app_text.dart';

class FirebaseRepository {
  Future<String?> uploadImage(
    File file, {
    required Function(String) error,
  }) async {
    try {
      return FirebaseHelper.uploadImage(file);
    } catch (e) {
      debugPrint("=========>  CATCH ERROR :::: $e");
      error(AppText.somethingWrongImageUpload);
      return null;
    }
  }

  Future<bool> storeFeed({
    required String description,
    required Function(String) error,
    String? url,
  }) async {
    try {
      await FirebaseHelper.setFeed({
        "description": description,
        if (url != null) "image": url,
        "timestemp": DateTime.now().millisecondsSinceEpoch,
      });
      return true;
    } catch (e) {
      debugPrint("=========>  CATCH ERROR :::: $e");
      error(AppText.somethingWentWrong);
      return false;
    }
  }

  Future<List<FeedModel>> getFeeds() async {
    try {
      return await FirebaseHelper.getFeeds();
    } catch (e) {
      debugPrint("=========>  CATCH ERROR :::: $e");
      return [];
    }
  }

  Future<bool> setLike(
    String id,
    String type, {
    required Function(String) error,
  }) async {
    try {
      await FirebaseHelper.setLike(
        id,
        {"thisUser": type},
      );
      return true;
    } catch (e) {
      debugPrint("=========>  CATCH ERROR :::: $e");
      error(AppText.somethingWentWrong);
      return false;
    }
  }

  Future<bool> removeLike(
    String id, {
    required Function(String) error,
  }) async {
    try {
      await FirebaseHelper.removeLike(id, "thisUser");
      return true;
    } catch (e) {
      debugPrint("=========>  CATCH ERROR :::: $e");
      error(AppText.somethingWentWrong);
      return false;
    }
  }

  Future<CommentModel?> setComment(
    String id,
    String comment, {
    required Function(String) error,
  }) async {
    try {
      final CommentModel model = CommentModel(
        id: id,
        userId: "thisUser",
        comment: comment,
        timestemp: DateTime.now().millisecondsSinceEpoch,
        userName: "Crazzy Skull",
      );
      await FirebaseHelper.setComment(id, model.toJson());
      return model;
    } catch (e) {
      debugPrint("=========>  CATCH ERROR :::: $e");
      error(AppText.somethingWentWrong);
      return null;
    }
  }
}
