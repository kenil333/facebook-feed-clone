import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/feed_model.dart';

class FirebaseHelper {
  static final Reference storageRef = FirebaseStorage.instance.ref();
  static final DatabaseReference feedsRef =
      FirebaseDatabase.instance.ref("feeds");

  static Future<String> uploadImage(File file) async {
    final Reference imageRef =
        storageRef.child("feeds/${DateTime.now().millisecondsSinceEpoch}.png");
    await imageRef.putFile(file);
    return await imageRef.getDownloadURL();
  }

  static Future<void> setFeed(Map body) async {
    await feedsRef.push().set(body);
  }

  static Future<List<FeedModel>> getFeeds() async {
    final DataSnapshot snapshot = await feedsRef.get();
    if (snapshot.exists) {
      List<FeedModel> list = [];
      (snapshot.value as Map).forEach((key, value) {
        list.add(FeedModel.fromJson(key, value));
      });
      if (list.length > 1) {
        list.sort((a, b) => b.timestemp.compareTo(a.timestemp));
      }
      return list;
    } else {
      return [];
    }
  }

  static Future<void> setLike(String id, Map body) async {
    await feedsRef.child("$id/likes").set(body);
  }

  static Future<void> removeLike(String id, String userId) async {
    await feedsRef.child("$id/likes/$userId").remove();
  }

  static Future<void> setComment(String id, Map body) async {
    await feedsRef.child("$id/comments").push().set(body);
  }
}
