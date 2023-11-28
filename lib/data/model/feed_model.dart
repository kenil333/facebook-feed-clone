class FeedModel {
  final String id;
  final String description;
  final String? image;
  final int timestemp;
  List<LikeModel> likes;
  List<CommentModel> comments;

  FeedModel({
    required this.id,
    required this.description,
    required this.image,
    required this.timestemp,
    required this.likes,
    required this.comments,
  });

  factory FeedModel.fromJson(String key, Map data) {
    List<LikeModel> likeList = [];
    if (data["likes"] != null) {
      (data["likes"] as Map).forEach((key, value) {
        likeList.add(LikeModel(userId: key, type: value));
      });
    }
    List<CommentModel> commentsList = [];
    if (data["comments"] != null) {
      (data["comments"] as Map).forEach((key, value) {
        commentsList.add(CommentModel.fromJson(key, value));
      });
      if (commentsList.length > 1) {
        commentsList.sort((a, b) => b.timestemp.compareTo(a.timestemp));
      }
    }
    return FeedModel(
      id: key,
      description: data["description"],
      image: data["image"],
      timestemp: data["timestemp"],
      likes: likeList,
      comments: commentsList,
    );
  }
}

class LikeModel {
  final String userId;
  final String type;

  LikeModel({
    required this.userId,
    required this.type,
  });

  factory LikeModel.fromJson(String key, String type) =>
      LikeModel(userId: key, type: type);
}

class CommentModel {
  final String id;
  final String userId;
  final String comment;
  final int timestemp;
  final String userName;

  CommentModel({
    required this.id,
    required this.userId,
    required this.comment,
    required this.timestemp,
    required this.userName,
  });

  factory CommentModel.fromJson(String key, Map data) => CommentModel(
        id: key,
        userId: data["userId"],
        comment: data["comment"],
        timestemp: data["timestemp"],
        userName: data["userName"],
      );

  Map toJson() => {
        "userId": userId,
        "comment": comment,
        "timestemp": timestemp,
        "userName": userName,
      };
}
