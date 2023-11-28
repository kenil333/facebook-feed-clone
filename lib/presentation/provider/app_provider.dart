import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/helper/image_helper.dart';
import '../../data/model/feed_model.dart';
import '../../data/model/stored_image.dart';
import '../../domain/repository/api_repository.dart';
import '../../domain/repository/firebase_repository.dart';
import '../../utils/app_enum.dart';
import '../../utils/app_text.dart';

class AppProvider extends ChangeNotifier {
  final FirebaseRepository firebaseRepo = FirebaseRepository();
  final ApiRepository apiRepo = ApiRepository();
  final ScrollController feedsScroll = ScrollController();
  List<StoredImage> storedImages = [];

  addListnerToFeedScroll() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      feedsScroll.addListener(() {
        if (reactionFeedId.isNotEmpty) {
          changeReactionFeedId({});
        }
      });
    });
  }

  Map _reactionFeedId = {};
  Map get reactionFeedId => _reactionFeedId;
  void changeReactionFeedId(Map value) {
    _reactionFeedId = value;
    notifyListeners();
  }

  bool _uploadingImage = false;
  bool get uploadingImage => _uploadingImage;
  void changeUploadingImage(bool value) {
    _uploadingImage = value;
    notifyListeners();
  }

  bool _creatingPost = false;
  bool get creatingPost => _creatingPost;
  void changeCreatingPost(bool value) {
    _creatingPost = value;
    notifyListeners();
  }

  List<FeedModel> _feeds = [];
  List<FeedModel> get feeds => _feeds;
  void changeFeeds(List<FeedModel> value) {
    _feeds = value;
  }

  bool _updateFeeds = false;
  bool get updateFeeds => _updateFeeds;
  void changeUpdateFeeds(bool value) {
    _updateFeeds = value;
    notifyListeners();
  }

  Future<void> getFeeds() async {
    changeFeeds(await firebaseRepo.getFeeds());
    changeUpdateFeeds(!_updateFeeds);
  }

  Future<File?> loadImage(String id, String url) async {
    final int index = storedImages.indexWhere((element) => element.id == id);
    if (index != -1) {
      debugPrint("=========>  Returning First");
      return storedImages[index].image;
    } else {
      final File? file = await ImageHelper.checkAndGetImage(id);
      if (file != null) {
        storedImages.add(StoredImage(id: id, image: file));
        return file;
      } else {
        final File? storedFile = await apiRepo.resultImage(url, id);
        if (storedFile != null) {
          storedImages.add(StoredImage(id: id, image: storedFile));
          return storedFile;
        } else {
          return null;
        }
      }
    }
  }

  void createPost(
    String description,
    File? image, {
    required Function(String) error,
    required Function success,
  }) async {
    String? imageUrl;
    if (image != null) {
      changeUploadingImage(true);
      imageUrl = await getImageUrl(image, error: error);
      changeUploadingImage(false);
    }
    changeCreatingPost(true);
    final bool complete = await firebaseRepo.storeFeed(
      description: description,
      error: error,
      url: imageUrl,
    );
    if (complete) {
      await getFeeds();
      try {
        feedsScroll.jumpTo(0);
      } catch (e) {
        debugPrint("=======>  No Scroll Attached...");
      }
      success();
    }
    changeCreatingPost(false);
  }

  Future<String?> getImageUrl(
    File file, {
    required Function(String) error,
  }) async {
    final String? url = await firebaseRepo.uploadImage(
      file,
      error: error,
    );
    if (url != null) {
      return url;
    } else {
      return null;
    }
  }

  void likePress(
    Reaction reaction,
    String feedId, {
    required bool fromReaction,
    required Function(String) error,
  }) async {
    final int feedIndex = _feeds.indexWhere((element) => element.id == feedId);
    if (feedIndex != -1) {
      final int index = _feeds[feedIndex]
          .likes
          .indexWhere((element) => element.userId == "thisUser");
      if (index != -1) {
        if (fromReaction) {
          if (reaction.key != _feeds[feedIndex].likes[index].type) {
            final bool success = await firebaseRepo.setLike(
              feedId,
              reaction.key,
              error: error,
            );
            if (success) {
              _feeds[feedIndex].likes.removeAt(index);
              _feeds[feedIndex]
                  .likes
                  .add(LikeModel(userId: "thisUser", type: reaction.key));
              notifyListeners();
              changeUpdateFeeds(!_updateFeeds);
            }
          }
        } else {
          final bool success =
              await firebaseRepo.removeLike(feedId, error: error);
          if (success) {
            _feeds[feedIndex].likes.removeAt(index);
            notifyListeners();
            changeUpdateFeeds(!_updateFeeds);
          }
        }
      } else {
        final bool success = await firebaseRepo.setLike(
          feedId,
          reaction.key,
          error: error,
        );
        if (success) {
          _feeds[feedIndex]
              .likes
              .add(LikeModel(userId: "thisUser", type: reaction.key));
          notifyListeners();
          changeUpdateFeeds(!_updateFeeds);
        }
      }
      if (reactionFeedId.isNotEmpty) {
        changeReactionFeedId({});
      }
    } else {
      error(AppText.somethingWentWrong);
    }
  }

  void addComment(
    String comment,
    String feedId, {
    required Function(String) error,
    required Function success,
  }) async {
    final int feedIndex = _feeds.indexWhere((element) => element.id == feedId);
    if (feedIndex != -1) {
      final CommentModel? model = await firebaseRepo.setComment(
        _feeds[feedIndex].id,
        comment,
        error: error,
      );
      if (model != null) {
        _feeds[feedIndex].comments.add(model);
        if (_feeds[feedIndex].comments.length > 1) {
          _feeds[feedIndex]
              .comments
              .sort((a, b) => b.timestemp.compareTo(a.timestemp));
        }
        notifyListeners();
        changeUpdateFeeds(!_updateFeeds);
        success();
      }
    } else {
      error(AppText.somethingWentWrong);
    }
  }
}
